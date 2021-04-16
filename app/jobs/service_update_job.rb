class ServiceUpdateJob < ApplicationJob
  queue_as :default

  def perform(service, movie_pages)
    MovieAvailability.where(service: service).destroy_all

    movie_pages.each do |movie_page|
      movie_page[:titles].each do |movie_data|
        movie = Movie.find_by(tmdb_id: movie_data[:tmdb_id])
        unless movie
          movie = Movie.create(
            title: movie_data[:title],
            tmdb_id: movie_data[:tmdb_id],
            year: movie_data[:year]
          )
        end
        movie.movie_availabilities.create(service: service)
      end
    end
  end
end
