class Service < ApplicationRecord
  validates_presence_of :name, :watchmode_id, :logo

  has_many :movie_availabilities
  has_many :movies, through: :movie_availabilities
end
