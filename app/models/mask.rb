class Mask < ApplicationRecord
  belongs_to :user

  has_many :reservations
end
