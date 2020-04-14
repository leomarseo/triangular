class AddDeletedToReservations < ActiveRecord::Migration[6.0]
  def change
    add_column :reservations, :deleted, :boolean, default: false
  end
end
