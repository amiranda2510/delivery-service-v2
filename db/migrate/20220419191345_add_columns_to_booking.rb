class AddColumnsToBooking < ActiveRecord::Migration[5.2]
  def change
    add_column :bookings, :status, :integer
    add_column :bookings, :assigned_driver, :boolean
  end
end
