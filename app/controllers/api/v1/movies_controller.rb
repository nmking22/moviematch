class Api::V1::MoviesController < ApplicationController
  def index
    render json: MovieSerializer.new(Movie.all)
  end

  def show
    render json: MovieSerializer.new(Movie.find(params[:id]))
  end

  def create
    movie = Movie.create(movie_params)
    render json: MovieSerializer.new(movie)
  end

  private

    def movie_params
      params.permit(:title, :tmdb_id)
    end
end
