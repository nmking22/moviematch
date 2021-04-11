class Api::V1::ServicesController < ApplicationController
  def index
    render json: ServiceSerializer.new(Service.all)
  end

  def show
    render json: ServiceSerializer.new(Service.find(params[:id]))
  end

  def create
    service = Service.create(service_params)
    render json: ServiceSerializer.new(service)
  end

  private

    def service_params
      params.permit(:name, :watchmode_id, :logo)
    end
end
