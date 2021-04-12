class Service < ApplicationRecord
  validates_presence_of :name, :watchmode_id, :logo

  has_many :movie_availabilities
end
