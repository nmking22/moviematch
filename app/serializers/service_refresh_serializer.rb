class ServiceRefreshSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :movie_count
end
