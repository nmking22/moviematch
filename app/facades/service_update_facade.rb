class ServiceUpdateFacade
  def self.refresh_availability(service_name)
    id = service_watchmode_id(service_name)
    service = Service.find_by(watchmode_id: id)

    movie_pages = WatchmodeService.get_movies_by_service(id)

    # ADD CONDITIONAL HERE - IF WATCHMODE API CALL SUCCESSFUL, DO THINGS, ELSE ERROR
    # MovieAvailabilities must be destroyed/recreated with each refresh
    # due to Watchmode API endpoint limitations & rate limits
    ServiceUpdateJob.perform_later(service, movie_pages)

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
