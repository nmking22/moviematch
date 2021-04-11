class Movie < ApplicationRecord
  validates_presence_of :title, :tmdb_id

  has_many :movie_availabilities
end
