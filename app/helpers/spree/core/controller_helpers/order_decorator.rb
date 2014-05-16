Spree::Core::ControllerHelpers::Order.module_eval  do

  # The current incomplete order from the session for use in cart and during checkout
  def current_order(create_order_if_necessary = false)
    return @current_order if @current_order
    if session[:order_id]
      current_order = Spree::Order.find_by_id_and_currency(session[:order_id], current_currency, :include => :adjustments)
      @current_order = current_order unless current_order.try(:completed?)
    end
    if create_order_if_necessary and (@current_order.nil? or @current_order.completed?)
      @current_order = Spree::Order.new(:currency => current_currency)
      @current_order.user ||= try_spree_current_user
      @current_order.wholesale = spree_current_user.wholesaler? if spree_current_user
      before_save_new_order
      @current_order.save!

      # make sure the user has permission to access the order (if they are a guest)
      if try_spree_current_user.nil?
        session[:access_token] = @current_order.token
      end
    end
    if @current_order
      if spree_current_user
        if spree_current_user.wholesaler? && !@current_order.is_wholesale?
          @current_order.to_wholesale!
        elsif !spree_current_user.wholesaler? && @current_order.is_wholesale?
          @current_order.to_fullsale!
        end
      end
      @current_order.last_ip_address = ip_address
      session[:order_id] = @current_order.id
      return @current_order
    end

    session[:order_id] = @current_order ? @current_order.id : nil
    @current_order
  end
end
