Spree::Core::ControllerHelpers::Order.module_eval  do

  # The current incomplete order from the session for use in cart and during checkout
  def current_order(options = {})
    options[:create_order_if_necessary] ||= false
    options[:lock] ||= false
    return @current_order if @current_order
    if session[:order_id]
      current_order = Spree::Order.includes(:adjustments).lock(options[:lock]).where(id: session[:order_id], currency: current_currency).first
      @current_order = current_order unless current_order.try(:completed?)
    end

    if options[:create_order_if_necessary] and (@current_order.nil? or @current_order.completed?)
      @current_order = Spree::Order.new(currency: current_currency)
      @current_order.user ||= try_spree_current_user
      @current_order.wholesale = spree_current_user.wholesaler? if spree_current_user
      # See issue #3346 for reasons why this line is here
      @current_order.created_by ||= try_spree_current_user
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
  end
end
