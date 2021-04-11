class MovieSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :tmdbid, :poster_path, :description, :genres, :vote_average, :vote_count, :year
end
