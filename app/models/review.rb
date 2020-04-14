class Review < ApplicationRecord
  belongs_to :reviewable, polymorphic: true, optional: true
  validates :content, presence: true
  validates :rating, presence: true
end
