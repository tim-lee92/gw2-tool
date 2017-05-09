class DonationsController < ApplicationController
  def new
  end

  def create
    token = params[:stripeToken]
    amount = params[:donation_amount][0].to_i * 100

    charge = StripeWrapper::Charge.create(
      amount: amount,
      description: 'GW2tool donation',
      source: token
    )

    if charge.successful?
      Donation.create(user: current_user, amount: amount, stripe_transaction_id: charge.response.id)
      flash[:notice] = 'Thank\'s for your support!'
      redirect_to home_path
    else
      flash[:error] = charge.error_message
      render :new
    end
  end
end
