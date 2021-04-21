class User < ApplicationRecord
  validates_presence_of :email,
                        :first_name,
                        :last_name,
                        :image,
                        :uid

  has_many :swipes
  has_many :movies, through: :swipes
end
