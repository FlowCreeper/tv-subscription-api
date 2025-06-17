class Api::AdicionalServicesController < ApplicationController
  before_action :set_adicional_service, only: [ :show, :update, :destroy ]

  # GET /api/adicional_services
  def index
    adicional_services = AdicionalService.all
    render json: adicional_services
  end

  # GET /api/adicional_services/:id
  def show
    render json: @adicional_service
  end

  # POST /api/adicional_services
  def create
    adicional_service = AdicionalService.new(adicional_service_params)
    if adicional_service.save
      render json: adicional_service, status: :created
    else
      render json: { errors: adicional_service.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/adicional_services/:id
  def update
    if @adicional_service.update(adicional_service_params)
      render json: @adicional_service
    else
      render json: { errors: @adicional_service.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /api/adicional_services/:id
  def destroy
    @adicional_service.destroy
    head :no_content
  end

  private

  def set_adicional_service
    @adicional_service = AdicionalService.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "AdicionalService not found" }, status: :not_found
  end

  def adicional_service_params
    params.require(:adicional_service).permit(:name, :price)
  end
end
