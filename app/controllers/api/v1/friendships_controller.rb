class Api::V1::FriendshipsController < ApplicationController
  def create
    friend = User.find_by(email: friendship_params[:friend_email])
    if friend
      friendship = Friendship.create(
        user_id: friendship_params[:user_id],
        friend: friend
      )
      render json: UserSerializer.new(friend)
    else
      output = {
        error: 'Invalid email. Friend not added.'
      }
      render json: output, :status => 400
    end
  end

  private

  def friendship_params
    params.permit(:user_id, :friend_email)
  end
end
