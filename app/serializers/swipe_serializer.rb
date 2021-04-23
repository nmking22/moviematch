class SwipeSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :user_id, :movie_id, :rating
end
