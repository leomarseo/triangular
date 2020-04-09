class RemoveReservationFromReviews < ActiveRecord::Migration[6.0]
  def change
    remove_reference :reviews, :reservation, null: false, foreign_key: true
  end
end
