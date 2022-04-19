class AddServiceIdToBooking < ActiveRecord::Migration[5.2]
  def change
    add_column :bookings, :service_id, :string
    add_column :bookings, :payload, :json
  end
end
