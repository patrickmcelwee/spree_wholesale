ApplicationHelper.module_eval do

  def wholesaler_signed_in?
    spree_current_user && spree_current_user.has_spree_role?("wholesaler")
  end

end
