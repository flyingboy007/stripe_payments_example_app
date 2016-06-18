class PurchaseMailer < ActionMailer::Base
  layout 'purchase_mailer'
  default from: "Stripe Test Payment Project <test@test.com>"

  def purchase_receipt purchase
    @purchase = purchase
    mail to: purchase.email, subject: "Thanks for the purchase"
  end
end