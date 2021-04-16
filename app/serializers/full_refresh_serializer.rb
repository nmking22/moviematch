class FullRefreshSerializer
  include FastJsonapi::ObjectSerializer
  attributes :total_movie_count, :service_refreshes
end
