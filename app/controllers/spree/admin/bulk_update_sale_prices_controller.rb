class Spree::Admin::BulkUpdateSalePricesController < Spree::Admin::BaseController
  before_action :load_product, only: :index
  before_action :bulk_update_sale_prices, only: :create

  def create
    redirect_to admin_bulk_update_sale_prices_path
  end

  private

  def load_product
    @product = Spree::Product.new
  end

  def taxon_products
    Spree::Product.joins(:taxons).where("taxon_id IN (?)", params[:product][:taxon_ids].split(",")).uniq
  end

  def bulk_update_sale_prices
    percentage = params[:percentage].to_f/100
    if !params[:product][:taxon_ids].present?
      flash[:error] = 'Taxon must exist'
    else
      begin
        Spree::Product.transaction do
          taxon_products.each do |product|
            product.sale_prices.active.each do |active_sale_price|
              active_sale_price.update(enabled: false, end_at: DateTime.now, calculator: Spree::Calculator::PercentOffSalePriceCalculator.new)
            end

            product.put_on_sale(percentage, { calculator_type: Spree::Calculator::PercentOffSalePriceCalculator.new, all_variants: true, start_at: params[:start_at].to_datetime, end_at: params[:end_at].to_datetime, enabled: true })
          end
        end
        flash[:success] = 'Sale prices updated successfully'
      rescue Exception => e
        flash[:error] = e
      end
    end
  end
end

# touched on 2025-05-22T23:47:18.372737Z