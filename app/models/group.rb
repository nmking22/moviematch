class Group < ApplicationRecord
  validates_presence_of :name

  has_many :user_groups
  has_many :users, through: :user_groups
end
