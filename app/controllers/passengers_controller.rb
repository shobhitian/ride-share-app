class PassengersController < ApplicationController
  before_action :authenticate_user!


#to show all booked rides from current user
  # def booked_publishes
  #   booked_passengers = Passenger.where(user_id: current_user.id)
  #   rides = booked_passengers.map { |passenger| passenger.publish }

  #   render json: { code: 200, rides: rides }, status: :ok
  # end
  def booked_publishes
    booked_passengers = Passenger.where(user_id: current_user.id)
    rides = booked_passengers.map do |passenger|
      {
        ride: passenger.publish,
        booking_id: passenger.id,
        seat: passenger.seats,
        status: passenger.status,
       
      }
    end
  
    render json: { code: 200, rides: rides }, status: :ok
  end
  

  def book_publish
    publish = Publish.find_by(id: params[:passenger][:publish_id])

    if publish
      if publish.user_id == current_user.id
        render json: {code: 422, error: "You cannot book your own published ride" }, status: :unprocessable_entity
        return
      end

      if publish.passengers_count > 0
        seats = params[:passenger][:seats].to_i

        if publish.passengers_count >= seats
          @passenger = Passenger.new(book_params)
          @passenger.price = publish.set_price * seats
          @passenger.status = "confirm booking"

          if @passenger.save
            publish.update(passengers_count: publish.passengers_count - seats)
            render json: { code: 201, passenger: @passenger }, status: :created
          else
            error_message = @passenger.errors.full_messages.first
            
            render json: { code: 422, error: error_message }, status: :unprocessable_entity
          end
        else
          render json: { code: 422, error: "Insufficient seats available" }, status: :unprocessable_entity
        end
      else
        render json: { code:422, error: "No seats available for this ride" }, status: :unprocessable_entity
      end
    else
      render json: { code:422, error: "Invalid publish" }, status: :unprocessable_entity
    end
  end

  def cancel_booking
    @passenger = Passenger.find_by(id: params[:id])
  
    if @passenger && @passenger.user_id == current_user.id
      if @passenger.status == "cancel booking"
        render json: { code: 422, error: "Ride has already been cancelled" }, status: :unprocessable_entity
      else
        publish = @passenger.publish
        seats = @passenger.seats
  
        if publish
          publish.update(passengers_count: publish.passengers_count + seats)
        end
  
        @passenger.update(status: "cancel booking")
        render json: { code: 200, message: "Ride successfully cancelled" }, status: :ok
      end
    else
      render json: { code: 422, error: "Invalid passenger or unauthorized" }, status: :unprocessable_entity
    end
  end
  

  def complete_ride
    @passenger = Passenger.find_by(id: params[:id])

    if @passenger && @passenger.user_id == current_user.id
      @passenger.update(status: "ride completed")
      render json: { code: 200, message: "Ride successfully completed" }, status: :ok
    else
      render json: { code: 422, error: "Invalid passenger or unauthorized" }, status: :unprocessable_entity
    end
  end

  private

  def book_params
    params.require(:passenger).permit(:publish_id, :seats).merge(user_id: current_user.id)
  end
end
