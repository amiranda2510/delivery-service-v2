class Booking
  include Mongoid::Document

  field :origin_address, type: String
  field :origin_lat, type: Float
  field :origin_lon, type: Float
  field :destiny_address, type: String
  field :destiny_lat, type: Float
  field :destiny_lon, type: Float
  field :service_id, type: String
  field :status, type: Integer
  field :assigned_driver, type: Boolean

end