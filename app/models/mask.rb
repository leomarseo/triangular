class Mask < ApplicationRecord
  # searchkick
  belongs_to :user
  has_many :reservations
  has_many :reviews, as: :reviewable
  validates :description, presence: true
  validates :condition, presence: true
  validates :size, presence: true, inclusion: { in: %w[Child Adult Hagrid] }

<<<<<<< HEAD
  # include PgSearch::Model
  # pg_search_scope :search_by_location_and_start_and_end_time,
  #   against: [:location, :start_time, :end_time],
  #   using: {
  #     tsearch: { prefix: true }
  #   }
=======
  def rating
    return false if reviews.count.zero?

    sum = 0.0
    reviews.each do |review|
      sum += review.rating
    end
    (sum / reviews.count * 100).truncate
  end
>>>>>>> master
end
