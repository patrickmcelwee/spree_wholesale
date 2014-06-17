require 'test_helper'

class Spree::ProductTest < ActiveSupport::TestCase

  should "respond to wholesale price" do
    variant = Factory.build(:wholesale_variant)
    product = variant.product
    assert product.master.respond_to?(:wholesale_price), "Product is not wholesale ready."
  end

  should "be wholesaleble" do
    variant = Factory.create(:wholesale_variant)
    product = variant.product
    product.master = variant
    assert product.is_wholesaleable?
  end

end
