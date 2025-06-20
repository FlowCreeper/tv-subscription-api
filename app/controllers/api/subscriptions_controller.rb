class Api::SubscriptionsController < ApplicationController
  before_action :set_subscription, only: [ :show, :update, :destroy ]

  # GET /api/subscriptions
  def index
    subscriptions = Subscription.all
    render json: subscriptions.to_json(include: :adicional_services)
  end

  # GET /api/subscriptions/:id
  def show
    render json: @subscription.to_json(include: :adicional_services)
  end

  # POST /api/subscriptions
  def create
    subscription = Subscription.new(subscription_params)

    if subscription.save
      render json: subscription, status: :created
    else
      render json: { errors: subscription.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/subscriptions/:id
  def update
    if @subscription.update(subscription_params)
      render json: @subscription
    else
      render json: { errors: @subscription.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /api/subscriptions/:id
  def destroy
    @subscription.destroy
    head :no_content
  end

  private

  def set_subscription
    @subscription = Subscription.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Subscription not found" }, status: :not_found
  end

  def subscription_params
    params.require(:subscription).permit(
      :customer_id,
      :plan_id,
      :package_id,
      adicional_service_ids: [] # expects array of additional service IDs
    )
  end
end
