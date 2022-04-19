class CreateBookings < ActiveRecord::Migration[5.2]
  def change
    create_table :bookings do |t|
      t.string :origin_address
      t.float :origin_lat
      t.float :origin_lon
      t.string :destiny_address
      t.float :destiny_lat
      t.float :destiny_lon

      t.timestamps
    end
  end
end
