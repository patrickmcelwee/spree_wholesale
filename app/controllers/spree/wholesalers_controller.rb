class Spree::WholesalersController < Spree::StoreController
  respond_to :html, :xml

  ssl_required :new, :create

  def index
  end

  def show
    @wholesaler = Spree::Wholesaler.find(params[:id])
    respond_with(@wholesaler)
  end

  def new
    @wholesaler = Spree::Wholesaler.new
    @wholesaler.build_user
    @wholesaler.bill_address = Spree::Address.default
    @wholesaler.ship_address = Spree::Address.default
    respond_with(@wholesaler)
  end

  def create
    @wholesaler = Spree::Wholesaler.new(wholesaler_params)
    if @wholesaler.save
      flash[:notice] = I18n.t('spree.wholesaler.signup_success')
      WholesaleMailer.new_wholesaler_email(@wholesaler).deliver
      redirect_to spree.wholesalers_path
    else
      flash[:error] = I18n.t('spree.wholesaler.signup_failed')
      render :action => "new"
    end
  end

  def edit
    @wholesaler = Spree::Wholesaler.find(params[:id])
    respond_with(@wholesaler)
  end

  def update
    @wholesaler = Spree::Wholesaler.find(params[:id])

    if @wholesaler.update_attributes(wholesaler_params)
      flash[:notice] = I18n.t('spree.wholesaler.update_success')
    else
      flash[:error] = I18n.t('spree.wholesaler.update_failed')
    end
    respond_with(@wholesaler)
  end

  def destroy
    @wholesaler = Spree::Wholesaler.find(params[:id])
    @wholesaler.destroy
    flash[:notice] = I18n.t('spree.wholesaler.destroy_success')
    respond_with(@wholesaler)
  end

  private

  def permitted_address_attributes
    [:firstname, :lastname, :address1, :address2, :city, :state_id, :zipcode, :country_id, :phone]
  end

  def wholesaler_params
    params.require(:wholesaler).
      permit(:ship_address, :bill_address, :company, :buyer_contact,
             :manager_contact, :phone, :fax, :resale_number,
             :taxid, :web_address, :terms, :notes, :use_billing,
             user_attributes: [:email, :password, :password_confirmation],
             bill_address_attributes: permitted_address_attributes,
             ship_address_attributes: permitted_address_attributes)
  end
end
