class RemoveActiveFromMasks < ActiveRecord::Migration[6.0]
  def change
    remove_column :masks, :active, :boolean
  end
end
