class TmdbFacade
  def self.populate_movie_details(movies)
    movies.each do |movie|
      movie_data = TmdbService.get_movie_info(movie)
      movie_info = MovieInfo.new(movie_data)
      movie.update(
        poster_path: movie_info.poster_path,
        description: movie_info.description,
        vote_average: movie_info.vote_average,
        vote_count: movie_info.vote_count,
        year: movie_info.year
      )
      movie_info.genres.each do |genre|
        current_genre = Genre.create_with(name:genre[:name]).find_or_create_by(tmdb_id:genre[:id])
        current_genre.movie_genres.create(movie:movie)
      end
    end
  end
end
