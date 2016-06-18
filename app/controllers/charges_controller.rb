class ChargesController < ApplicationController
  def create
    @amount = 500
    customer = Stripe::Customer.create(
        email: params[:stripeEmail],
        card: params[:stripeToken]
    )

    charge = Stripe::Charge.create(
        customer: customer.id,
        amount: params[:amount],
        description: "A month's subscription",
        currency: 'usd'
    )
    purchase = Purchase.create(email: params[:stripeEmail],
                               card: params[:stripeToken],
                               amount: params[:amount],
                               description: charge.description,
                               currency: charge.currency,
                               customer_id: customer.id,
                               product_id: 1, uuid: SecureRandom.uuid)

    redirect_to purchase
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to charges_path
  end
end