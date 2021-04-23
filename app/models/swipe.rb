class Swipe < ApplicationRecord
  validates_presence_of :rating

  belongs_to :movie
  belongs_to :user
end
