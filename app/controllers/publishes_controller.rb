class PublishesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_publish, only: [:show, :update, :destroy]
  
  # GET /publishes
  def index
    @publishes = Publish.all.where(user_id:current_user.id)

    render json: @publishes
  end

  

  # GET /publishes
  def show
    render json: @publish
  end
  









  # POST /publishes
  # def create
  #   @publish = current_user.publishes.new(publish_params)
    

  #   if @publish.save
  #     render json: @publish, status: :created, location: @publish
  #   else
  #     render json: @publish.errors, status: :unprocessable_entity
  #   end
  # end


  def create
    @publish = current_user.publishes.new(publish_params)
  
    if current_user.vehicles.exists?(id: @publish.vehicle_id)
      if @publish.save
        render json: @publish, status: :created, location: @publish
      else
        render json: @publish.errors, status: :unprocessable_entity
      end
    else
      render json: { error: 'Invalid vehicle_id' }, status: :unprocessable_entity
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
  end





  private
  
  def set_publish
    @publish = Publish.find(params[:id])
  end

  def publish_params
    params.require(:publish).permit(:source, :destination, :source_longitude, :source_latitude, :destination_longitude, :destination_latitude, :passengers_count, :add_city, :date, :time, :set_price, :about_ride, :vehicle_id, :book_instantly, :mid_seat, select_route: {}).tap do |whitelisted|
      whitelisted[:vehicle_id] = params[:publish][:vehicle_id] if params[:publish].has_key?(:vehicle_id)
    end
  end
  
end
