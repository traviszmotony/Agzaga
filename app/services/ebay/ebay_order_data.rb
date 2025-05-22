module Ebay
  class EbayOrderData < Base
    def initialize
      super

      @ebay_order_url = "https://api.ebay.com/sell/fulfillment/v1/order/"
    end

    def get_order_data(order_id)
      url = URI(@ebay_order_url + order_id.to_s)

      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true

      request = Net::HTTP::Get.new(url)
      request['Authorization'] ="Bearer #{@access_token}"
      request['Content-Type'] = 'application/json'

      response = https.request(request)
      if response.code == '401' && @access_token_exp.past?
        mint_access_token(:get_order_data, order_id)
      else
        add_Ebay_log(response.code, 'Order data fecthed successfully', order_id)

        JSON.parse response.read_body
      end
    end
  end
end

# touched on 2025-05-22T19:23:23.765034Z
# touched on 2025-05-22T20:38:05.166928Z
# touched on 2025-05-22T23:47:04.459885Z