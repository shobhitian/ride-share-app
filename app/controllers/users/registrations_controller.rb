class Users::RegistrationsController < Devise::RegistrationsController
  
  respond_to :json
 

  
  def respond_with(resource, options={})
    if resource.persisted?
      render json: {
        status: { code: 200, message: 'Signed up successfully', data: resource }
        
      }, status: :ok
    # else
    #   if resource.errors[:email].include?("has already been taken")
    #     render json: {
    #       status: { code: 401, message: 'User already registered' },
    #       errors: resource.errors.full_messages
    #     }, status: :unauthorized
      else
        render plain: resource.errors.full_messages.first, status: :unprocessable_entity

    end
  end
  


  def update
    user = current_user
    if user.update(user_params)
      render json: {
        status: { code: 200, message: 'User updated successfully', data: user },
        }
    else
      render json: {
        status: { code: 422, message: 'User could not be updated', errors: user.errors.full_messages }
      }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotFound => error
    render json: { error: error.message }, status: :unauthorized
  end



  
  def destroy
    user = current_user
    user.destroy
    render json: { status: { code: 200, message: 'User deleted successfully' } }
  rescue ActiveRecord::RecordNotFound => error
    render json: { error: error.message }, status: :unauthorized
  end


  
  def show
    
    render json: {
      status: { code: 200, data: current_user }
      
    }, status: :ok
  end
  
  private
  
  def sign_up_params
    params.require(:user).permit(:email, :first_name, :last_name, :dob, :title, :password, :phone_number)
  end

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :bio, :postal_address, :title, :dob, :travel_preferences, :phone_number)
  end

end 