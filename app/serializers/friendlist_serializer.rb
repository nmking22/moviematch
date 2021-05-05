class FriendlistSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :friends
end
