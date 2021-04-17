class MovieInfo
  attr_reader :poster_path,
              :description,
              :vote_average,
              :vote_count,
              :year,
              :genres

  def initialize(movie_data)
    @poster_path = movie_data[:poster_path]
    @description = movie_data[:overview]
    @vote_average = movie_data[:vote_average]
    @vote_count = movie_data[:vote_count]
    @year = movie_data[:release_date].first(4)
    @genres = movie_data[:genres]
  end
end
