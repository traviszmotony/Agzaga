module Spree

  class PagesController < Spree::StoreController
    layout :set_layout
    before_action :load_product, only: :chuckwagon_dvd
    before_action :load_data, only: :chuckwagon_dvd
    include Products::Cards
    helper_method :load_product_cards

    def faq_page
      @help_center = Spree::HelpCenter.order(:position)
    end

    def faq
    end

    def privacy_policy
    end

    def contact
    end

    def mill
    end

    def shipping_policy
    end

    def error_page
    end

    def freedom_wrap
      @summer_deal_products = Spree::Product.available.deal_prodcuts('Summer Deal')
      @summer_deal_product_cards = load_product_cards(@summer_deal_products)
    end

    def august_event
      @pick_up_products = Spree::Product.available.deal_prodcuts('Pick Up Product').order(:available_on, :created_at)
      @pick_up_group_products = Spree::Product.available.deal_prodcuts('Pick Up Group').order(:available_on, :created_at)
    end

    def chuckwagon_dvd
      @chuckwagon_winner_enrollment = Spree::StoreCreditWinner.new
      @chuckwagon_races_products = Spree::Product.find(Spree::View::ChuckwagonRacesProduct.pluck(:id))
      @horse_accessories = Spree::Product.find(Spree::View::ChuckwagonHorseAccessory.pluck(:id))
      @upsell_products = Spree::Product.find(Spree::View::UpsellProduct.pluck(:id))
      @out_door_boards = Spree::Product.find(Spree::View::ChuckwagonOutdoorBoard.pluck(:id))
      @out_door_products = Spree::Product.find(Spree::View::ChuckwagonOutdoorAccessory.pluck(:id))

      @summer_deal_products = Spree::Product.find(Spree::View::ChuckwagonSummerDeal.pluck(:id))

      if @product.present?
        @product_question = Spree::ProductQuestion.new(product: @product)
        @review = Spree::Review.new(product: @product)
        @visible_taxons = @product.taxons.where(visibility: true)
      end
    end

    def net_wraps
      @net_wrap_products = Spree::View::NetWrapProduct.all.limit(3).includes(:master)
      @inductry_net_wraps = Spree::View::NetWrapProduct.all.offset(3).limit(2).includes(:master)
    end

    def usa
      briddon_flag_products = Spree::View::FlagProduct.where(tag: 'Briddon USA Flag Products')
      @briddon_flag_products = briddon_flag_products.limit(3)
      @briddon_flag_products_count = briddon_flag_products.count

      ariat_flag_products = Spree::View::FlagProduct.where(tag: 'Ariat Flag Products')
      @ariat_flag_products = ariat_flag_products.limit(3)
      @ariat_flag_products_count = ariat_flag_products.count

      allied_flag_products = Spree::View::FlagProduct.where(tag: 'Allied Flag Products')
      @allied_flag_products = allied_flag_products.limit(3)
      @allied_flag_products_count = allied_flag_products.count

      accessories_flag_products = Spree::View::FlagProduct.where(tag: 'Accessories Flag Products')
      @accessories_flag_products = accessories_flag_products.limit(3)
      @accessories_flag_products_count = accessories_flag_products.count
    end

    def briddon_usa_flag_products_cards
      flag_products = Spree::View::FlagProduct.all.where(tag: 'Briddon USA Flag Products').offset(load_params[:offset]).limit(load_params[:limit])
      load_product_cards flag_products
    end

    def ariat_flag_products_cards
      flag_products = Spree::View::FlagProduct.all.where(tag: 'Ariat Flag Products').offset(load_params[:offset]).limit(load_params[:limit])
      load_product_cards flag_products
    end

    def allied_flag_products_cards
      flag_products = Spree::View::FlagProduct.all.where(tag: 'Allied Flag Products').offset(load_params[:offset]).limit(load_params[:limit])
      load_product_cards flag_products
    end

    def accessories_flag_products_cards
      flag_products = Spree::View::FlagProduct.all.where(tag: 'Accessories Flag Products').offset(load_params[:offset]).limit(load_params[:limit])
      load_product_cards flag_products
    end

    private

    def load_params
      params.permit(:limit, :offset, :tab)
    end

    def set_layout
      'landing_page' if ['freedom_wrap', 'august_event', 'net_wraps', 'usa'].include?(action_name)
    end

    def load_product
      if try_spree_current_user.try(:has_spree_role?, "admin")
        @products = Spree::Product.with_discarded
      else
        @products = Spree::Product.available
      end

      @product = @products.find(Spree::View::ChuckwagonPreOrder.pluck(:id)).first
    end

    def load_data
      if @product.present?
        @product_properties = @product.product_properties.includes(:property)

        if params[:highest_rating].present?
          @reviews = @product.reviews.reorder('spree_reviews.rating DESC').page(params[:reviews_page] || 1 ).per(3)

        elsif params[:lowest_rating].present?
          @reviews = @product.reviews.reorder('spree_reviews.rating ASC').page(params[:reviews_page] || 1 ).per(3)

        else
          @reviews = @product.reviews.page(params[:reviews_page] || 1 ).per(3)
        end

        @product_questions = @product.product_questions.page(params[:questions_page] || 1 ).per(3)
      end
    end
  end
end

# touched on 2025-05-22T19:17:29.027822Z
# touched on 2025-05-22T23:43:54.073563Z