  # frozen_string_literal: true

module Spree
  class TaxonsController < Spree::StoreController
    helper 'spree/products', 'spree/taxon_filters'

    before_action :load_taxon, only: [:show]
    before_action :load_taxon_children_data, only: [:load_taxon_children]

    respond_to :html
    include Products::Cards
    include Products::ProductFilters

    def show
      @searcher = build_searcher(params.merge(taxon: @taxon.id, include_images: true))
      @deals_products = Spree::DealsPage.where(visibility: true).first
      tag =  @deals_products.present? ? @deals_products&.tag : "Deals"

      if params[:deals].present?
        products = Spree::Product.available.joins(:taxons).where(taxons: {id: @taxon.id})
        @products = (products.sale_products + products.deal_prodcuts(tag)).uniq
      else
        taxon_ids = [@taxon.id]
        taxon_ids << Spree::Taxon.find(taxon_ids).map{|t| t.descendants.pluck(:id)}
        @products = Spree::Product.available.joins(:taxons).where("spree_taxons.id IN (?)", taxon_ids.flatten).select("spree_products.id")
      end

      if params[:order_by_staff_pick].present? || (!params[:order_by].present? && !params[:filter_by].present?)
        product_ids_sorted = Spree::View::ProductsSortByStaffPick.pluck(:id)
        @products = @products.index_by(&:id).extract!(*product_ids_sorted).values
      end

      if params[:filter_by].present?
        @products = filter_category_products
      end

      if params[:order_by].present?
        @products = order_products
      end

      @taxonomies = Spree::Taxonomy.where(visibility: true).includes(root: :children)
      @products = Kaminari.paginate_array(@products).page(params.dig(:page) || 1 ).per(48)
      load_product_cards(@products)
    end

    def load_taxon_children
      respond_to do |format|
        format.js
      end
    end

    private

    def load_taxon
      @taxon = Spree::Taxon.find_by!(permalink: taxon_params[:id])
    end

    def accurate_title
      if @taxon
        @taxon.seo_title
      else
        super
      end
    end

    def best_seller_products
      product_ids = @products.map {|product| product.id}
      products = Spree::Product.where(id: product_ids)
      products.best_sellers
    end


    def filter_category_products
      case params[:filter_by]
      when 'Staff Pick'
        @products =  @products.deal_prodcuts('Staff Pick')
      when 'Best Seller'
        @products = best_seller_products
      when 'Sale'
        @products = @products.sale_products
      else
        []
      end
    end

    def taxon_params
      params.permit(:id)
    end

    def load_taxon_children_data
      @taxon = Spree::Taxon.find(taxon_params[:id]) if taxon_params[:id]
      sql = "SELECT t.id, t.name, t.permalink, (SELECT count(t1.id)  FROM spree_taxons AS t1 WHERE t1.parent_id = t.id GROUP BY t1.parent_id) AS children_count  FROM spree_taxons AS t WHERE t.parent_id = #{taxon_params[:id]} AND t.visibility = true ORDER BY t.id ASC;"
      @taxon_children = ActiveRecord::Base.connection.exec_query(sql).to_a
    end
  end
end

# touched on 2025-05-22T19:22:39.716107Z
# touched on 2025-05-22T23:05:18.210089Z