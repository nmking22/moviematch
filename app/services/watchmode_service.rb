class WatchmodeService
  def self.get_movies_by_service(service_id, page = 1, output = [])
    response = conn.get('/v1/list-titles/') do |req|
      req.params['type'] = 'movie'
      req.params['regions'] = 'US'
      req.params['source_ids'] = service_id.to_s
      req.params['source_types'] = 'sub'
      req.params['page'] = page
    end

    json = JSON.parse(response.body, symbolize_names: true)
    output << json

    # Recursion used here to get movie data for all pages
    # (Watchmode limits results to 250 movies/page)
    if json[:total_pages] > page
      get_movies_by_service(service_id, page + 1, output)
    else
      output
    end
  end

  private

    def self.conn
      Faraday.new(url: 'https://api.watchmode.com') do |req|
        req.params['apiKey'] = ENV['WATCHMODE_API_KEY']
      end
    end
end
