class Movie < ApplicationRecord
  validates_presence_of :title, :tmdb_id

  has_many :movie_availabilities
  has_many :services, through: :movie_availabilities
end
