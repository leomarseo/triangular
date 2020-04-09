class AddColumnsToMasks < ActiveRecord::Migration[6.0]
  def change
    add_column :masks, :deleted, :boolean
    add_column :masks, :start_time, :string
    add_column :masks, :end_time, :string
    add_column :masks, :price, :float
  end
end
