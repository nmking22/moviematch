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

  def update
    movie = Movie.find(params[:id])
    movie.update(movie_params)
    render json: MovieSerializer.new(movie)
  end

  def destroy
    Movie.destroy(params[:id])
  end

  private

    def movie_params
      params.permit(:title, :tmdb_id, :poster_path, :description, :genres, :vote_average, :vote_count, :year)
    end
end
