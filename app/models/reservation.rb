class Reservation < ApplicationRecord
  belongs_to :mask
  belongs_to :user
  has_one :review, as: :reviewable
  validates :start_time, presence: true
  validates :end_time, presence: true
  # validates :active, default: true
end
