module Spree
  module WholesaleOrderDecorator
    def payment_required?
      super && !_wholesale_with_net_terms?
    end

    def is_wholesale?
      wholesale
    end

    def wholesale
      read_attribute(:wholesale) && !wholesaler.nil?
    end

    def wholesaler
      user && user.wholesaler
    end

    def set_line_item_prices(use_price=:price)
      line_items.includes(:variant).each do |line_item|
        line_item.price = line_item.variant.send(use_price)
        line_item.save
      end
    end

    def to_fullsale!
      self.wholesale = false
      set_line_item_prices(:price)
      update!
      save
    end

    def to_wholesale!
      return false unless user.wholesaler.present?
      self.wholesale = true
      set_line_item_prices(:wholesale_price)
      update!
      save
    end

    def add_variant(variant, quantity = 1, currency = nil)
      current_item = find_line_item_by_variant(variant)
      if current_item
        current_item.quantity += quantity
        current_item.currency = currency unless currency.nil?
        current_item.save
      else
        current_item = Spree::LineItem.new(:quantity => quantity)
        current_item.variant = variant
        if currency
          current_item.currency = currency unless currency.nil?
          current_item.price   = is_wholesale? ? variant.wholesale_price : variant.price_in(currency)
        else
          current_item.price   = is_wholesale? ? variant.wholesale_price : variant.price
        end
        self.line_items << current_item
      end

      self.reload
      current_item
    end

    private

    def _wholesale_with_net_terms?
      is_wholesale? && wholesaler.terms != 'Credit Card'
    end
  end

  Order.class_eval do
    prepend WholesaleOrderDecorator
  end

end
