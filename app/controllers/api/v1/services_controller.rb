class Api::V1::ServicesController < ApplicationController
  def index
    render json: ServiceSerializer.new(Service.all)
  end
end
