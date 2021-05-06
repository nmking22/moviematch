class FriendshipSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :user_id, :friend_id
end
