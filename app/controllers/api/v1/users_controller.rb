class Api::V1::UsersController < ApplicationController
  def create
    user = User.find_by(uid: params[:uid])
    unless user
      user = User.create(user_params)
    end
    render json: UserSerializer.new(user)
  end

  private

  def user_params
    params.permit(:uid, :first_name, :last_name, :image, :email)
  end
end
