require 'json'
require 'httparty'

class BookingsController < ApplicationController
  include HTTParty
  before_action :set_booking, only: [:show, :update, :destroy]

  TOKEN = 'ccRtcEaHTyfRUu-5_GgOCADWVxcfaTfORqDwYLseZ-rJ_WsM-hjgDw'
  @base_uri = "https://sandbox.picap.co/api/:url?t=#{TOKEN}"

  # GET /bookings
  def index
    @bookings = Booking.all
  end

  # GET //bookings/
  def new
    @booking = Booking.new
  end

  # GET /bookings/1
  def show; end

  # POST /bookings
  def create
    base_uri = "https://sandbox.picap.co/api/third/bookings?t=#{TOKEN}"
    create_request = {
      "booking":{
          "address": booking_params[:origin_address],
          "lat": booking_params[:origin_lat],
          "lon": booking_params[:origin_lon],
          "requested_service_type_id": "5c71b03a58b9ba10fa6393cf",
          "return_to_origin": false,
          "requires_a_driver_with_base_money": false,
          "stops":[
            {
                "address": booking_params[:destiny_address],
                "lat": booking_params[:destiny_lat],
                "lon": booking_params[:destiny_lon],
                "packages":[
                  {
                      "indications": "Indicaciones",
                      "declared_value": {
                        "sub_units": 210000,
                        "currency": "COP"
                      },
                      "reference": "Pedido 1",
                      "counter_delivery": false,
                      "size_cd": 1
                  }
                ]
            }
          ]
      }
    }

    response = HTTParty.post( base_uri, 
    :body => 
      create_request.to_json,
    :headers => { 'Content-Type' => 'application/json' } )

    @booking = Booking.create(booking_params)
    @booking.update(service_id: response["_id"], status: response["status_cd"], assigned_driver: response["driver"] ? 1 : 0 )

    render json: @booking
  end

  # PATCH/PUT /bookings/1
  def update
    base_uri = "https://sandbox.picap.co/api/third/bookings/#{@booking.service_id}/cancel?t=#{TOKEN}"

    response = HTTParty.patch(base_uri, 
    :headers => { 'Content-Type' => 'application/json' } )

    render :show
  end

  # DELETE /bookings/1
  def destroy
    @booking.destroy
  end

  private

    def booking_params
      params.require(:booking).permit(:origin_address, :origin_lat, :origin_lon, :destiny_address, :destiny_lat, :destiny_lon)
    end  

    def set_booking
      @booking = Booking.find(params[:id])
    end

end
