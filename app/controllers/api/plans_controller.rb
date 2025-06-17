class Api::PlansController < ApplicationController
  before_action :set_plan, only: [ :show, :update, :destroy ]

  # GET /api/plans
  def index
    plans = Plan.all
    render json: plans
  end

  # GET /api/plans/:id
  def show
    render json: @plan
  end

  # POST /api/plans
  def create
    plan = Plan.new(plan_params)
    if plan.save
      render json: plan, status: :created
    else
      render json: { errors: plan.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/plans/:id
  def update
    if @plan.update(plan_params)
      render json: @plan
    else
      render json: { errors: @plan.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /api/plans/:id
  def destroy
    @plan.destroy
    head :no_content
  end

  private

  def set_plan
    @plan = Plan.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Plan not found" }, status: :not_found
  end

  def plan_params
    params.require(:plan).permit(:name, :price)
  end
end
