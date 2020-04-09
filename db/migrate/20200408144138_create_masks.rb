class CreateMasks < ActiveRecord::Migration[6.0]
  def change
    create_table :masks do |t|
      t.string :description
      t.string :condition
      t.float :price
      t.string :size
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
