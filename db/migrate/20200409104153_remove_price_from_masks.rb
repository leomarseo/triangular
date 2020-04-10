class RemovePriceFromMasks < ActiveRecord::Migration[6.0]
  def change
    remove_column :masks, :price, :float
  end
end
