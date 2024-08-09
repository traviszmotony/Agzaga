module NetSuite
  class SalesOrder < Base

    def initialize
      super
      @root = 'https://6983452.suitetalk.api.netsuite.com/services/rest/record/v1/'
      @query_url = 'https://6983452.suitetalk.api.netsuite.com/services/rest/query/v1/suiteql'
      @sales_order_root = @root + 'salesOrder/'
    end

    def get_order_data id
      url = URI(@sales_order_root + id.to_s)

      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true

      request = Net::HTTP::Get.new(url)
      request["Authorization"] = "Bearer #{ @access_token }"
      request["Content-Type"] = "application/json"

      response = https.request( request )

      if response.code == '401' && @access_token_exp.past?
        refersh_token(:get_order_data, id)
      else
        JSON.parse response.read_body
      end
    end

    def create order_id
      order = Spree::Order.find_by_id order_id

      return false unless valid_order_for_NS?(order)

      url = URI(@sales_order_root)

      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true

      request = Net::HTTP::Post.new(url)
      request["Content-Type"] = "application/json"

      request.body = JSON.dump( prepare_data(order) )

      request["Authorization"] = "Bearer #{ @access_token }"
      response = https.request( request )

      if response.code == '401' && @access_token_exp.past?
        refersh_token(:create, order_id)
      elsif response.code == '204'
        true
        add_NS_log(response.code, "Order #{order.number}, (id: #{order.id}) created successfully", order.id)
      else
        log_error_and_notify_admin( response, "Can not create sales order: #{response.read_body}", order_id)
      end
    end

    def get_items_ids sku_list, order_id
      url = URI(@query_url)

      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true

      request = Net::HTTP::Post.new(url)
      request["prefer"] = "transient"
      request["Content-Type"] = "application/json"
      request["Authorization"] = "Bearer #{ @access_token }"

      query_data = sku_list.map {|item| "'#{item}'" }.join(',')

      request.body = JSON.dump({
        "q": "SELECT id, itemid FROM item WHERE itemid IN (#{query_data})"
      })

      response = https.request(request)

      if response.code == '401' && @access_token_exp.past?
        refersh_token(:get_items_ids, sku_list, order_id)
      elsif response.code == '200'
        res = JSON.parse response.read_body
        if res['count'] == 0
          log_error_and_notify_admin(response, 'No product found on net suite', order_id)
        elsif res['count'] != sku_list.count
          log_error_and_notify_admin(response, 'Some product SKU not found on net suite', order_id)
        else
          add_NS_log(response.code, 'Fetched items ids successfully', order_id)
          res['items'].map{|i| {id: i['id'], sku: i['itemid']}}
        end
      else
        log_error_and_notify_admin( response, "#{response.read_body}", order_id)
      end
    end

    private

    def prepare_data order
      data = {
        entity: {id: order.user.present? ? create_or_update_customer(order.user, order) : 99 },
        memo: prepare_memo_for_order(order),
        otherRefNum: prepare_order_number(order),
        item: {
          items: prepare_items_for_order(order)
        },
        location: { id: 6 },
        customForm: { id: 182 },
        shippingAddress: prepare_address(order.ship_address)
                          .merge!(attention: order.ship_address.name, addressee: order.ship_address.phone, isResidential: true),
        shippingCost: order.shipment_total.to_f,
        shipMethod: { id: ns_ship_method_id(order) },
        billingAddress: prepare_address(order.bill_address),
        custbody_kjc_agzutmsource: order.utm_source,
        custbody_kjc_agzreflink: order.ref,
        custbody_kjc_agzdevice: { id: ns_device_id_by_name(order.device_type) }
      }

      data
    end

    def prepare_order_number order
      payment_method_name = order.payments.find_by(state: "completed").payment_method.name
      return payment_method_name != "Stripe" ? payment_method_name + ": " + order.number : order.number
    end

    def ns_device_id_by_name(device_name)
      device_mapping = {
        'Desktop' => 1,
        'mobile-iOS' => 2,
        'mobile-android' => 3,
        'tablet-iOS' => 4,
        'tablet-android' => 5
      }

      device_mapping[device_name] || 0
    end

    def prepare_memo_for_order order
      data = ENV['APPLICATION_ENV'] == 'production' ? '' : "Test Order. "

      if order.custom_hose_configurations.present?
        data.concat("Custom Hose configurations: ")

        order.custom_hose_configurations.includes(custom_hose: :option_values, fitting_1: :option_values, fitting_2: :option_values).each_with_index do |config, index|
          custom_hose = "Product: #{index + 1}, Color: #{config.custom_hose.option_values.pluck(:name).join(', ')}, length: #{config.length}, fitting-1: #{config.fitting_1.option_values.pluck(:name).join(', ')}, fitting-2: #{config.fitting_2.option_values.pluck(:name).join(', ')}. "
          data.concat(custom_hose)
        end
      end
      data.html_safe
    end

    def prepare_items_for_order order
      res = get_items_ids(order.line_items.map(&:sku), order.id)
      @applied_promo_codes = []

      data = order.line_items.each_with_index.map do |item,index|
        [{
          item:
            { id: res.find{|i| i[:sku] == item.sku}[:id] },
            rate: item.price.to_f,
            quantity: item.quantity,
            inventorylocation: { id: 6 }
        }].concat(add_promo_data_for_line(item))
      end

      data.flatten.concat(prepare_promo_items_for(order))
    end

    def add_promo_data_for_line item
      promotions = item.adjustments.eligible.promotion

      return [] unless promotions.present?

      promo_data = promotions.map do |promotion|
        @applied_promo_codes << promotion

        p_data =  {
                    item: { refName: promotion.promotion_code.value },
                    rate: promotion.amount.to_f,
                    price: { id: -1},
                    itemType: "Discount"
                  }
      end
    end

    def prepare_promo_items_for order
      promotions = order.all_adjustments.eligible.promotion
      aplyable_promotions = promotions - @applied_promo_codes.uniq
      return [] unless aplyable_promotions.present?

      data = aplyable_promotions.map do |promotion|
        {
          item: { refName: promotion.promotion_code.value },
          rate: promotion.amount.to_f,
          price: { id: -1},
          itemType: "Discount"
        }
      end
    end

    def prepare_address address
        {
          addr1: address.address1,
          addr2: address.address2,
          city: address.city,
          country: { id: "US" },
          state: address.state.name,
          zip: address.zipcode,
        }
    end

    def ns_ship_method_id order
      name = order&.shipments&.last&.shipping_method&.name
      name&.include?('Expedited') ? 2961 :  615
    end

    def find_customer customer_email
      url = URI(@query_url)

      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true

      request = Net::HTTP::Post.new(url)
      request["prefer"] = "transient"
      request["Content-Type"] = "application/json"
      request["Authorization"] = "Bearer #{@access_token}"
      request.body = JSON.dump({
        "q": "SELECT id FROM customer WHERE email = '#{customer_email}'"
      })

      response = https.request(request)

      if response.code == '401' && @access_token_exp.past?
        refersh_token(:find_customer, customer_email)
      elsif response.code == '200'
        data = JSON.parse(response.read_body)
        return nil if data['count'] == 0
        agz_customer_id = get_latest_agz_customer_id(data['items'].pluck('id').map(&:to_i)) if data['count'] > 0
      else
        log_error_and_notify_admin(response, "#{JSON.parse(response.read_body)}")
      end
    end

    def get_latest_agz_customer_id ns_customer_ids
      ns_customer_ids.sort.reverse!
      ns_customer_ids.each do |id|
        return id if agz_customer?(id)
      end
      return nil
    end

    def agz_customer? ns_customer_id
      url = URI("#{@root}customer/#{ns_customer_id}?fields=subsidiary")

      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true

      request = Net::HTTP::Get.new(url)
      request["Authorization"] = "Bearer #{@access_token}"

      response = https.request(request)

      if response.code == '401' && @access_token_exp.past?
        refersh_token(:agz_customer?, ns_customer_id)
      elsif response.code == '200'
        data = JSON.parse(response.read_body)
        data['subsidiary']['id'].to_i == 4
      else
        log_error_and_notify_admin(response, "#{JSON.parse(response.read_body)}")
      end
    end

    def create_or_update_customer customer, order
      ns_customer_id = find_customer(customer.email)
      url = URI("#{@root}customer#{ ns_customer_id.present? ? "/#{ns_customer_id}" : '' }")

      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true

      request = ns_customer_id.present? ? Net::HTTP::Patch.new(url) : Net::HTTP::Post.new(url)
      request["Content-Type"] = "application/json"

      request.body = JSON.dump( prepare_customer_data(order, ns_customer_id) )

      request["Authorization"] = "Bearer #{@access_token}"
      response = https.request(request)

      if response.code == '401' && @access_token_exp.past?
        refersh_token(:create_or_update_customer, customer)
      elsif response.code == '204'
        add_NS_log(response.code, 'Customer created/updated successfully', order.id)
        ns_customer_id.present? ? ns_customer_id : find_customer(customer.email)
      else
        log_error_and_notify_admin(response, message: 'Something went wrong while create/update customer', order_id: order.id)
      end
    end

    def prepare_customer_data order, ns_customer_id
      customer = order.user
      address = customer.bill_address || customer.ship_address || order.bill_address || order.ship_address
      {
        firstName: address.firstname,
        lastName: address.lastname,
        isPerson: true,
        phone: address.phone,
        email: customer.email,
        comments: "Business Name: #{address.businessname} #{', Test Customer' unless ENV['APPLICATION_ENV'] == 'production'}",
        subsidiary: { id: 4 },
        addressBook: {
          items: prepare_address_book_items(order, ns_customer_id)
        },
        terms: {
          refName: 'Pay to ship'
        },
        priceLevel: {
          refName: 'Agzaga Site Price'
        },
        globalSubscriptionStatus: {
          refName: 'Soft Opt-In'
        },
        emailPreference: {
          refName: 'PDF'
        },
        customForm: {
         id: 142
        }
      }
    end

    def prepare_address_book_items order, ns_customer_id
      customer = order.user
      billing_address = customer.bill_address || order.bill_address
      shipment_address = customer.ship_address || order.ship_address

      if ns_customer_id.present?
        address_ids = ns_address_book_ids(ns_customer_id)
      end

      if(billing_address.id == shipment_address.id)
        [{
          addressBookAddress: prepare_address(billing_address),
          isResidential: true,
          defaultBilling: true,
          defaultShipping: true
        }.merge!(ns_customer_id.present? && address_ids[:ns_bill_address_id].present? ? {internalId: address_ids[:ns_bill_address_id]} : {})]
      else
        [{
          addressBookAddress: prepare_address(billing_address),
          defaultBilling: true,
          defaultShipping: false,
          isResidential: true
        }.merge!(ns_customer_id.present? && address_ids[:ns_bill_address_id].present? ? {internalId: address_ids[:ns_bill_address_id]} : {}),
        {
          addressBookAddress: prepare_address(shipment_address),
          isResidential: true,
          defaultBilling: false,
          defaultShipping: true,
        }.merge!( ns_customer_id.present? && address_ids[:ns_ship_address_id].present? && (address_ids[:ns_bill_address_id] != address_ids[:ns_ship_address_id]) ? {internalId: address_ids[:ns_ship_address_id]} : {})]
      end
    end

    def ns_address_book_ids ns_customer_id
      url = URI("#{@root}customer/#{ns_customer_id}/addressBook?expandSubResources=true")

      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true

      request = Net::HTTP::Get.new(url)
      request["Authorization"] = "Bearer #{@access_token}"

      response = https.request(request)

      if response.code == '401' && @access_token_exp.past?
        refersh_token(:ns_address_book_ids, ns_customer_id)
      elsif response.code == '200'
        data = JSON.parse response.read_body

        if data['items'].count == 0
          {
            ns_bill_address_id: nil,
            ns_ship_address_id: nil
          }
        elsif data['items'].count == 1
          {
            ns_bill_address_id: (data['items'].first['defaultBilling'] ? data['items'].first['id'] : nil),
            ns_ship_address_id: (data['items'].first['defaultShipping'] ? data['items'].first['id'] : nil)
          }
        else
          {
            ns_bill_address_id: data['items'].find{|i| i['defaultBilling']==true}['id'],
            ns_ship_address_id: data['items'].find{|i| i['defaultShipping']==true}['id']
          }
        end
      else
        log_error_and_notify_admin(response, message: "Something went wrong while getting address book ids for NS customer #{ns_customer_id}")
      end
    end

    def valid_order_for_NS? order
      if order.line_items.present? && order.complete?
        true
      else
        add_NS_log('', 'NS sales order create method called for incomplete/empty order', order.id)
        
        NetSuiteNotificationMailer.error_email('NS sales order create method called for incomplete/empty order').deliver

        false
      end
    end
  end
end

# touched on 2025-05-22T20:41:45.043170Z
# touched on 2025-05-22T20:43:46.765071Z
# touched on 2025-05-22T20:44:34.095973Z
# touched on 2025-05-22T23:46:38.742330Z