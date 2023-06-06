class UserImagesController < ApplicationController
  
  before_action :only => [:update]

  
  def update
      user = current_user
      if user.image.attach(params[:image])
          render json: { 
          status: {code: 200, message: 'Image successfully updated', image_url: url_for(user.image), data: user},
          
          
      }
      else
          render json: { 
          status: {code: 422, error: 'must be a JPEG or PNG file'}
          }, status: :unprocessable_entity
      end
  end
        
end