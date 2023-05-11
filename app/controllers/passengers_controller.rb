class PassengersController < ApplicationController
    before_action :authenticate_user!
  
    # POST /publishes/:publish_id/passengers
    def create
      publish = Publish.find(params[:publish_id])
      passenger = publish.passengers.new(user: current_user)
  
      if passenger.save
        render json: passenger, status: :created
      else
        render json: passenger.errors, status: :unprocessable_entity
      end
    end
  
    # DELETE /publishes/:publish_id/passengers/:id
    def destroy
      publish = Publish.find(params[:publish_id])
      passenger = publish.passengers.find(params[:id])
  
      passenger.destroy
      head :no_content
    end
  end
  