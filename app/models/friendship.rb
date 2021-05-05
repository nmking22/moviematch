class Friendship < ApplicationRecord
  validates_presence_of :user_id,
                        :friend_id
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  def self.exists?(user_id, friend_id)
    Friendship.where(user_id: user_id).where(friend_id: friend_id) != []
  end
end
