Spree::PermittedAttributes.product_attributes << :wholesale_price

Spree::Product.instance_eval do
  delegate_belongs_to :master, :wholesale_price if Spree::Variant.table_exists? && Spree::Variant.column_names.include?("wholesale_price")
end

Spree::Product.class_eval do

  def is_wholesaleable?
    0.01 < master.wholesale_price
  end

  def self.wholesaleable
    wholesale_products = []
    all.each do |p|
      wholesale_products << p if p.is_wholesaleable?
    end
    wholesale_products
  end

end
