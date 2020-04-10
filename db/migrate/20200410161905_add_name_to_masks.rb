class AddNameToMasks < ActiveRecord::Migration[6.0]
  def change
    add_column :masks, :name, :string
  end
end
