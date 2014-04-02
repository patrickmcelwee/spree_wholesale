class WholesaleMailer < ActionMailer::Base
  helper "spree/base"
  layout 'mailer'

  def new_wholesaler_email(wholesaler)
    @wholesaler = wholesaler
    subject = "New Wholesale Application Received: #{wholesaler.company}"
    mail(:to => "orders@example.com", 
	 :from => "noreply@example.com", 
	 :subject => subject)
  end

  def approve_wholesaler_email(wholesaler)
    @wholesaler = wholesaler
    subject = "Wholesale Account Approved for #{wholesaler.company}"
    mail(:to => wholesaler.email, :subject => subject)
  end
    
end
