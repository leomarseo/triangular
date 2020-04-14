class Mask < ApplicationRecord
  # searchkick
  belongs_to :user
  has_many :reservations
  has_many :reviews, as: :reviewable
  validates :description, presence: true
  validates :condition, presence: true
  validates :size, presence: true, inclusion: { in: %w[Child Adult Hagrid] }

  def rating
    return false if reviews.count.zero?

    sum = 0.0
    reviews.each do |review|
      sum += review.rating
    end
    (sum / reviews.count * 100).truncate
  end
end
