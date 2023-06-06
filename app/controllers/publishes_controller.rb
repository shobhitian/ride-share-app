class PublishesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_publish, only: [:show, :update, :destroy]
  
  # GET /publishes
  def index
    @publishes = Publish.all.where(user_id: current_user.id)
    render json: { code: 200, data: @publishes }
  end
  

  def show
    @rides = Passenger.where(publish_id: @publish.id)
    @user = User.find_by(id: @publish.user_id)
    @vehicle = Vehicle.find_by(id: @publish.vehicle_id)
    passengers = []
    @rides.each do |ride|
      user = User.find_by(id: ride.user_id)
      passengers << user.first_name if user.present?
    end
    render json: {
      status: 200,
      data: @publish,
      first_name: @user.first_name,
      passengers: passengers,
      vehicle_name: @vehicle.vehicle_name,
      vehicle_color: @vehicle.vehicle_color
    }
  end
  

  def create
    @publish = current_user.publishes.new(publish_params)
  
    @publish.status = "pending" # Set initial status to "pending"
  
    if @publish.save
      render json: {code: 201, publish: @publish}
    else
      render json: {code: 422, publish: @publish.errors, status: :unprocessable_entity }
    end
  end
  

  # PATCH/PUT /publishes/1
  def update
    if @publish.update(publish_params)
      render json: @publish
    else
      render json: @publish.errors, status: :unprocessable_entity
    end
  end

 
  # DELETE /publishes/1
  def destroy
    @publish.destroy
    render json: { message: 'Publish successfully deleted.' }
  end


  def cancel_publish
    @publish = Publish.find(params[:id])
  
    if @publish.update(status: "cancelled")
      render json: { message: "Publish successfully cancelled." }
    else
      render json: @publish.errors, status: :unprocessable_entity
    end
  end



  # POST /publishes/:id/complete_publish
  def complete_publish
    @publish = Publish.find(params[:id])
      if @publish.update(status: "completed")
        render json: { message: "Ride successfully completed." }
      else
        render json: @publish.errors, status: :unprocessable_entity
      end
   
  end

  private
  
  def set_publish
    @publish = Publish.find(params[:id])
  end

  def publish_params
    params.require(:publish).permit(:source, :destination, :source_longitude, :source_latitude, :destination_longitude, :destination_latitude, :passengers_count, :add_city, :add_city_longitude, :add_city_latitude, :date, :time, :set_price, :about_ride, :vehicle_id, :book_instantly, :mid_seat, :estimate_time, select_route: {})
    
  end
  
end
