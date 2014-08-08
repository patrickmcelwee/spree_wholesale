module SpreeWholesale
  module LineItemDecorator
    def copy_price
      super
      if variant
        self.price = (order.is_wholesale? && variant.is_wholesaleable? ? variant.wholesale_price : variant.price) if price.nil?
      end
    end
  end
end

Spree::LineItem.class_eval do
  prepend SpreeWholesale::LineItemDecorator

  delegate_belongs_to :variant, :wholesale_price
  delegate_belongs_to :variant, :is_wholesaleable?
end
