Spree::LineItem.class_eval do

  delegate_belongs_to :variant, :wholesale_price
  delegate_belongs_to :variant, :is_wholesaleable?

  def copy_price
    if variant
      self.price = (order.is_wholesale? && variant.is_wholesaleable? ? variant.wholesale_price : variant.price) if price.nil?
    end
  end

end
