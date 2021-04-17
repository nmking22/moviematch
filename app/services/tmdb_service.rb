class TmdbService
  def self.get_movie_info(movie)
    response = conn.get("/3/movie/#{movie.tmdb_id}")
    JSON.parse(response.body, symbolize_names:true)
  end

  private

    def self.conn
      Faraday.new(url: 'https://api.themoviedb.org') do |req|
        req.params['api_key'] = ENV['TMDB_API_KEY']
      end
    end
end
