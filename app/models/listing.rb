class Listing < ApplicationRecord
  belongs_to :mask
  validates :price, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
end
