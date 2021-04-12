class MovieAvailability < ApplicationRecord
  belongs_to :movie
  belongs_to :service
end
