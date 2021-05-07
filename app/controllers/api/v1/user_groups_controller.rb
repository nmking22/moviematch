class Api::V1::UserGroupsController < ApplicationController
  def create
    user_group = UserGroup.create(user_group_params)

    render json: UserGroupSerializer.new(user_group)
  end

  def destroy
    UserGroup.destroy(params[:id])
  end

  private

  def user_group_params
    params.permit(:user_id, :group_id)
  end
end
