class Api::V1::UsersController < ApplicationController
  def create
    user = User.find_by(uid: params[:uid])
    unless user
      user = User.create(user_params)
    end
    render json: UserSerializer.new(user)
  end

  def show
    user = User.find_by(uid: params[:id])
    if user
      render json: UserSerializer.new(user)
    else
      output = {
        error: 'User does not exist in database.'
      }
      render json: output, status: :bad_request
    end
  end

  def update
    user = User.find_by(uid: params[:id])
    user.update(user_params)
    render json: UserSerializer.new(user)
  end

  def friends
    user = User.find_by(id: params[:id])
    friendlist = Friendlist.new(user)
    render json: FriendlistSerializer.new(friendlist)
  end

  private

  def user_params
    params.permit(:uid, :first_name, :last_name, :image, :email)
  end
end
