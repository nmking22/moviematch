class Api::V1::MoviesController < ApplicationController
  def index
    render json: MovieSerializer.new(Movie.all)
  end

  def show
    render json: MovieSerializer.new(Movie.find(params[:id]))
  end
end
