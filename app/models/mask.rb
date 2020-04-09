class Mask < ApplicationRecord
  belongs_to :user
  has_many :reservations
  has_many :reviews, as: :reviewable
  validates :description, presence: true
  validates :condition, presence: true
  validates :size, presence: true, inclusion: { in: %w(Child Adult Hagrid) }
end
