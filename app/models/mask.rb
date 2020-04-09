class Mask < ApplicationRecord
  belongs_to :user

  has_many :reservations
  has_many :reviews, as: :reviewable
end
