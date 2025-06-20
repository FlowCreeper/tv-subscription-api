class Api::PackagesController < ApplicationController
  before_action :set_package, only: [ :show, :update, :destroy ]

  # GET /api/packages
  def index
    packages = Package.all
    render json: packages.to_json(include: :adicional_services)
  end

  # GET /api/packages/:id
  def show
    render json: @package.to_json(include: :adicional_services)
  end

  # POST /api/packages
  def create
    package = Package.new(package_params)

    if package.save
      render json: package, status: :created
    else
      render json: { errors: package.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/packages/:id
  def update
    if @package.update(package_params)
      render json: @package
    else
      render json: { errors: @package.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /api/packages/:id
  def destroy
    @package.destroy
    head :no_content
  end

  private

  def set_package
    @package = Package.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Package not found" }, status: :not_found
  end

  def package_params
    params.require(:package).permit(
      :name,
      :price,        # optional – will auto-calculate if blank
      :plan_id,
      adicional_service_ids: [] # expects an array of service IDs
    )
  end
end
