class MovieInfo
  attr_reader :poster_path,
              :description,
              :vote_average,
              :vote_count,
              :year,
              :genres

  def initialize(movie_data)
    @poster_path = movie_data[:poster_path]
    @description = add_description(movie_data)
    @vote_average = movie_data[:vote_average]
    @vote_count = movie_data[:vote_count]
    @year = find_year(movie_data)
    @genres = movie_data[:genres]
  end

  def find_year(movie_data)
    if movie_data[:release_date]
      movie_data[:release_date].first(4)
    else
      'Unknown'
    end
  end

  def add_description(movie_data)
    if movie_data[:description]
      movie_data[:description]
    else
      'No description available'
    end
  end
end
