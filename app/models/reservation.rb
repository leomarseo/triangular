class Reservation < ApplicationRecord
  belongs_to :mask
  belongs_to :user

  has_many :reviews, as: :reviewable
end
