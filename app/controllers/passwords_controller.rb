class PasswordsController < ApplicationController

  before_action :authenticate_user!
    def update
        user = current_user
        if user.valid_password?(params[:current_password])
          user.update(password: params[:password], password_confirmation: params[:password_confirmation])
          if user.errors.empty?
            render json: {status: {code: 200, message: 'Password updated successfully' }}, status: :ok
          else
            render json: {status: {code: 422, errors: user.errors }}, status: :unprocessable_entity
          end
        else
          render json: {status: {code: 422, error: 'Invalid current password' }}, status: :unprocessable_entity
        end
    end
    
end
