class FullRefresh
  attr_reader :id,
              :total_movie_count,
              :service_refreshes

  def initialize(service_refreshes)
    @id = nil
    @total_movie_count = add_movie_counts(service_refreshes)
    @service_refreshes = service_refreshes
  end

  def add_movie_counts(service_refreshes)
    service_refreshes.sum do |service_refresh|
      service_refresh.movie_count
    end
  end
end
