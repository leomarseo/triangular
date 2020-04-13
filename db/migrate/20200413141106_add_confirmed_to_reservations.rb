class AddConfirmedToReservations < ActiveRecord::Migration[6.0]
  def change
    add_column :reservations, :confirmed, :boolean
  end
end
