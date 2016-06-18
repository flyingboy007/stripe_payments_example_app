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



  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to charges_path
  end
end