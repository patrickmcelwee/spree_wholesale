class Spree::WholesalersController < Spree::BaseController
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
    @wholesaler = Spree::Wholesaler.new(params[:wholesaler])
    if @wholesaler.save

      # Check whether wholesaler should be auto-approved
      if Spree::Config.auto_approve_wholesaler && @wholesaler.activate!
        flash[:notice] = "Wholesale account approved for #{@wholesaler.company}. You may now sign in to place an order."
        redirect_to spree.login_path
        return
      end

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

    if @wholesaler.update_attributes(params[:wholesaler])
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

end
