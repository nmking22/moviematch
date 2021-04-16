class Movie < ApplicationRecord
  validates_presence_of :title, :tmdb_id

  has_many :movie_availabilities
  has_many :services, through: :movie_availabilities
  has_many :movie_genres
  has_many :genres, through: :movie_genres
end
