class Api::V1::SwipesController < ApplicationController
  def create
    swipe = Swipe.create(swipe_params)

    render json: SwipeSerializer.new(swipe)
  end

  private

  def swipe_params
    params.permit(:user_id, :movie_id, :rating)
  end
end
