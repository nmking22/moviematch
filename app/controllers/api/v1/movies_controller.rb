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

  def populate_details
    movies = Movie.needs_details
    if movies == []
      output = {
        movies_updated: 0,
        update_status: 'Complete - all movies are populated.'
      }
      render json: output
    elsif movies.length < 30
      TmdbFacade.populate_movie_details(movies)
      output = {
        movies_updated: movies.length,
        update_status: 'Complete - incomplete movies have been populated.'
      }
      render json: output
    else
      MovieDetailsUpdateJob.perform_later
      output = {
        movies_updated: movies.length,
        update_status: "In progress - details for #{movies.length} movies are currently being updated. Estimated completion time: #{Movie.estimated_update_time(movies.length)}."
      }
      render json: output
    end
  end

  def random_available
    movie = Movie.random_unswiped(params[:user_id].to_i)

    render json: MovieSerializer.new(movie)
  end

  private

    def movie_params
      params.permit(:title, :tmdb_id, :poster_path, :description, :vote_average, :vote_count, :year)
    end
end
