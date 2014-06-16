require 'test_helper'

class Spree::OrderTest < ActiveSupport::TestCase

  def setup
    @wholesaler = Factory.create(:wholesaler)
  end

  should "respond to wholesale" do
    order = Spree::Order.new
    assert order.respond_to?(:wholesale)
  end

  should "be wholesale" do
    order = Factory.create(:order, :user => @wholesaler.user, :wholesale => true)
    assert order.is_wholesale?
  end

  should "convert to wholesale" do
    order = Factory.create(:order, :user => Factory.create(:user))
    assert !order.is_wholesale?
    assert !order.to_wholesale!
    assert !order.is_wholesale?
    order.user.wholesaler = @wholesaler
    assert order.to_wholesale!
    assert order.is_wholesale?
  end

  should "get regular price" do
    order = Factory.create(:order)
    assert_equal 0, order.item_total
    order.add_variant(Factory.build(:wholesale_variant))
    order.update!
    assert_equal 19.99, order.item_total
  end

  should "get wholesale price" do
    order = Factory.create(:order, :user => @wholesaler.user, :wholesale => true)
    assert_equal 0, order.item_total
    order.add_variant(Factory.build(:wholesale_variant))
    order.update!
    assert_equal 9.5, order.item_total
  end

  should "not require payment if wholesale with net terms" do
    @wholesaler.terms = "Net30"
    @wholesaler.save!
    order = Factory.create(:order, :user => @wholesaler.user, :wholesale => true)
    order.add_variant(Factory.build(:wholesale_variant))
    assert(!order.payment_required?)
  end

  should "require payment if not wholesale with net terms" do
    order = Factory.create(:order, :user => @wholesaler.user, :wholesale => true)
    order.add_variant(Factory.build(:wholesale_variant))
    assert(order.payment_required?)

    order1 = Factory.create(:order, user: @wholesaler.user, wholesale: false)
    order1.add_variant(Factory.build(:wholesale_variant))
    assert(order1.payment_required?)

    order2 = Factory.create(:order)
    order2.add_variant(Factory.build(:wholesale_variant))
    assert(order2.payment_required?)
  end
end
