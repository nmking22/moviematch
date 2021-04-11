class MovieSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :tmdb_id, :poster_path, :description, :genres, :vote_average, :vote_count, :year
end
