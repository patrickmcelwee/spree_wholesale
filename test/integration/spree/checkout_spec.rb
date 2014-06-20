require 'test_helper'

class SpreeWholesale::CheckoutSpec < ActiveSupport::IntegrationCase
  should "allow a non-wholesaler to add product to cart" do
    Factory(:product, :name => "RoR Mug")
    visit spree.products_path
    click_link "RoR Mug"
    click_button "Add To Cart"
    within('h1') { assert page.has_content?("Shopping Cart") }
    assert page.has_content?('RoR Mug'), "Page did not have content 'RoR Mug' in #{page.text}"
  end
end
