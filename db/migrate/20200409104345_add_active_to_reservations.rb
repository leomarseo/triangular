class AddActiveToReservations < ActiveRecord::Migration[6.0]
  def change
    add_column :reservations, :active, :boolean
  end
end
