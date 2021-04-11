class Api::V1::MoviesController < ApplicationController
  def index
    render json: MovieSerializer.new(Movie.all)
  end
end
