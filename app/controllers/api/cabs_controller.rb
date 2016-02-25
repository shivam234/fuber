class Api::CabsController < ApplicationController
   # http_basic_authenticate_with name: "admin", password: "secret"
   before_action :set_cab, only: [:show, :edit, :update, :destroy]
   before_filter :restrict_access
  def index
    @cab = Cab.all
    respond_to do |format|
      format.json { render json: @cab }
      format.xml { render xml: @cab }
    end
  end

  def show
    respond_to do |format|
      format.json { render json: @cab }
      format.xml { render xml: @cab }
    end
  end

  # def create
  #   @cab = Cab.new(cab_params)
  #   respond_to do |format|
  #     if @cab.save
  #       format.json { render json: @cab, status: :created }
  #       format.xml { render xml: @cab, status: :created }
  #     else
  #       format.json { render json: @cab.errors, status: :unprocessable_entity }
  #       format.xml { render xml: @cab.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # def update
  #   respond_to do |format|
  #     if @cab.update_attributes(cab_params)
  #       format.json { head :no_content, status: :ok }
  #       format.xml { head :no_content, status: :ok }
  #     else
  #       format.json { render json: @cab.errors, status: :unprocessable_entity }
  #       format.xml { render xml: @cab.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  def destroy
    respond_to do |format|
      if @cab.destroy
        format.json { head :no_content, status: :ok }
        format.xml { head :no_content, status: :ok }
      else
        format.json { render json: @cab.errors, status: :unprocessable_entity }
        format.xml { render xml: @cab.errors, status: :unprocessable_entity }
      end
    end
  end

  def call_cab
    @customer=Customer.find(params[:cust_id])
    if !(@customer.cab_no).blank?
      render json: {message: "Customer already on the ride"}

    else
      request = @customer.request_type
      @cab = Cab.where(status:"available",cab_type:request)
      if !@cab.blank?
        min_dist = 999999999 # assuming the distance will not be greater than this value
        nearest_cab = 1
        @cab.each do |c|
          dist = ((c.location_x-@customer.location_x)**2 + (c.location_y-@customer.location_y)**2)**1/2
          if dist<min_dist
            min_dist = dist
            nearest_cab = c.id
          end
        end

          if Cab.find(nearest_cab).update(status:"booked",customer_id:params[:cust_id]) && Customer.find(params[:cust_id]).update(cab_no:nearest_cab)
            render json: {message: "Cab Booked Successfully"}

          else
            render json: {message: "ERROR"}
          end
      else
        render json: {message: "NO Cabs Available"}
      end
    end
  end

  def end_ride
    @customer = Customer.find(params[:cust_id])
    if !(@customer.cab_no).blank?
      Cab.find(@customer.cab_no).update(status:"available",customer_id:nil,location_x:@customer.destination_x,location_y:@customer.destination_y)
      Customer.find(params[:cust_id]).update(cab_no:nil)
      render json: {message: "Ride Ended Successfully"}
    else
      render json: {message: "Customer is not on the ride"}
    end
  end

  private
    def restrict_access
      api_key = ApiKey.find_by_access_token(params[:access_token])
      head :unauthorized unless api_key
    end

    def set_cab
      @cab = Cab.find(params[:id])
    end

    def cab_params
      params.require(:cab).permit!
    end
end
