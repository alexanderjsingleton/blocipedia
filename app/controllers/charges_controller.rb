class ChargesController < ApplicationController
  before_action :authenticate_user!
  def new
    @stripe_btn_data = {
    key: "#{ Rails.configuration.stripe[:publishable_key] }",
    description: "Big Money Membership - #{current_user.name || current_user.email}",
    amount: 1500
    }
  end

  def create
    # Amount in cents
    @amount = 1500

    customer = Stripe::Customer.create(
      email: current_user.email,
      card:  params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      customer:  customer.id,
      amount:    @amount,
      description: "Big Money Membership - #{current_user.name || current_user.email}",
      currency: 'usd'
    )

    current_user.role = 'premium'
    current_user.save

    flash[:notice] = "Thanks for your BigTime membership, #{current_user.name || current_user.email}"
    redirect_to wikis_path

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_charge_path
    end
end