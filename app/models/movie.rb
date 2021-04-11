class Movie < ApplicationRecord
  validates_presence_of :title, :tmdb_id
end
