class Api::V1::GroupsController < ApplicationController
  def index
    user = User.find(params[:user_id])
    groups = user.groups.map do |group|
      GroupSerializer.new(group)
    end
    render json: groups
  end

  def show
    group = Group.find(params[:id])
    render json: GroupSerializer.new(group)
  end

  def create
    group = Group.create(group_params)
    render json: GroupSerializer.new(group)
  end

  def destroy
    Group.destroy(params[:id])
  end

  private

  def group_params
    params.permit(:name)
  end
end
