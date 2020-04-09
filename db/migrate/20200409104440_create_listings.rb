class CreateListings < ActiveRecord::Migration[6.0]
  def change
    create_table :listings do |t|
      t.float :price
      t.string :start_time
      t.string :end_time
      t.references :mask, null: false, foreign_key: true

      t.timestamps
    end
  end
end
