class User < ApplicationRecord
  validates_presence_of :email,
                        :first_name,
                        :last_name,
                        :image,
                        :uid

  has_many :swipes
  has_many :movies, through: :swipes
  has_many :friendships
  has_many :friends, through: :friendships
  has_many :user_groups
  has_many :groups, through: :user_groups
end
