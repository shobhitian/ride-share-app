class RatingsController < ApplicationController
  before_action :authenticate_user!

  def create
    @rating = Rating.new(rating_params)
    @rating.rating_user_id = current_user.id

    if @rating.save
      render json: { message: 'Rating saved successfully' }, status: :ok
    else
      render json: { errors: @rating.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def rating_params
    params.require(:rating).permit(:rated_user_id, :value, :publish_id)
  end
end
