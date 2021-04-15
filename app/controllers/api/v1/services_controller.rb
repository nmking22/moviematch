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

  def update
    service = Service.find(params[:id])
    service.update(service_params)
    render json: ServiceSerializer.new(service)
  end

  def destroy
    Service.destroy(params[:id])
  end

  def update_availability
    service_refresh = ServiceUpdateFacade.refresh_availability(params[:service])
    render json: ServiceRefreshSerializer.new(service_refresh)
  end

  def update_all_availabilities
    full_refresh = ServiceUpdateFacade.refresh_all_availabilities

    render json: FullRefreshSerializer.new(full_refresh)
  end

  private

    def service_params
      params.permit(:name, :watchmode_id, :logo)
    end
end
