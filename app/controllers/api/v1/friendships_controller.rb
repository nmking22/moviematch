class Api::V1::FriendshipsController < ApplicationController
  def create
    friendship = Friendship.create(friendship_params)
    render json: FriendshipSerializer.new(friendship)
  end

  private

  def friendship_params
    params.permit(:user_id, :friend_id)
  end
end
