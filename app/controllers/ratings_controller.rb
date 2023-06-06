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


  def givenRating
    @ratings = Rating.where(rating_user_id: current_user.id)
  
    if @ratings.present?
      render json: { status: 200, data: @ratings }
    else
      render json: { error: "No ratings given yet" }
    end
  end
  
  
  
  
  def recievedRating
    @ratings = Rating.where(rated_user_id: current_user.id)
    @average_rating = @ratings.average(:value)
    @ratings_group = @ratings.group(:value).count
    
    if @ratings.present?
      render json: {
        status: 200,
        average: @average_rating,
        groups: @ratings_group,
        data: @ratings
      }
    else
      render json: {
        error: "No ratings have been received yet."
      }
    end
  end
  
  
  
  

  private

  def rating_params
    params.require(:rating).permit(:rated_user_id, :rating_user_id, :value, :publish_id)
  end
end
