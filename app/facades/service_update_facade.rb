class ServiceUpdateFacade
  def self.refresh_availability(service_name)
    id = service_watchmode_id(service_name)
    service = Service.find_by(watchmode_id: id)

    # MovieAvailabilities must be destroyed/recreated with each refresh
    # due to Watchmode API endpoint limitations & rate limits
    MovieAvailability.where(service: service).destroy_all

    movie_pages = WatchmodeService.get_movies_by_service(id)
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
    ServiceRefresh.new(service[:name], movie_pages[0][:total_results])
  end

  def self.refresh_all_availabilities
    service_refreshes = services.map do |name, id|
      refresh_availability(name.to_s)
    end
    FullRefresh.new(service_refreshes)
  end

  def self.service_watchmode_id(service_name)
    services[service_name.to_sym]
  end

  def self.services
    {
      netflix: 203,
      hulu: 157,
      amazon: 26
    }
  end
end
