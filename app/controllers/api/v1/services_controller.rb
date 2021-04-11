class Api::V1::ServicesController < ApplicationController
  def index
    render json: ServiceSerializer.new(Service.all)
  end

  def show
    render json: ServiceSerializer.new(Service.find(params[:id]))
  end
end
