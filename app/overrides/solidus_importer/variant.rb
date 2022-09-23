class SolidusImporter::Processors::Variant < SolidusImporter::Processors::Base
  attr_accessor :product

  def call( context )
    @data = context.fetch( :data )
    self.product = context.fetch( :product ) || raise( ArgumentError, 'missing :product in context' )

    context.merge!( variant: process_variant )
  end

  private

  def prepare_variant
    return product.master if master_variant?

    @prepare_variant ||= Spree::Variant.find_or_initialize_by( sku: sku ) do |variant|
      variant.product = product
    end
  end

  def process_variant
    prepare_variant.tap do |variant|

      variant[ :height ] = Spree::LocalizedNumber.parse( @data[ 'Variant Height' ] ) if @data[ 'Variant Height' ].present?
      variant[ :width ] = Spree::LocalizedNumber.parse( @data[ 'Variant Width' ] ) if @data[ 'Variant Width' ].present?
      variant[ :depth ] = Spree::LocalizedNumber.parse( @data[ 'Variant Depth' ] ) if @data[ 'Variant Depth' ].present?
      variant.weight = @data[ 'Variant Weight' ] unless @data[ 'Variant Weight' ].nil?
      variant.cost_price = @data[ 'Variant Cost Price' ] if @data[ 'Variant Cost Price' ].present?
      variant.save!
    end
  end

  def master_variant?
    ov1 = @data[ 'Option1 Value' ]
    ov1.blank? || ov1 == 'Default Title'
  end

  def sku
    @data[ 'Variant SKU' ] || generate_sku
  end

  def generate_sku
    variant_part = @data[ 'Option1 Value' ].parameterize
    "#{product.slug}-#{variant_part}"
  end
end

# touched on 2025-05-22T21:58:08.587301Z
# touched on 2025-05-22T23:07:39.179471Z