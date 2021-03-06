class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :reservations
  has_many :masks
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :address, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i }
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  has_one_attached :photo

  # You can find an object and update it with a one command
  # using update as class method.
  #
  # User.update(111, address: '16 Villa Gaudelet, Paris')
  has_many :reviews

  def rating_as_owner
    return false unless masks.any?

    sum = 0.0
    counter = 0
    masks.each do |mask|
      next unless mask.reviews.any?

      mask.reviews.each do |review|
        sum += review.rating
        counter += 1
      end
    end
    return false unless counter != 0

    (sum / counter * 100).truncate
  end

  def rating_as_customer
    return false unless reservations.any?

    sum = 0.0
    counter = 0
    reservations.each do |reservation|
      next if reservation.review.nil?

      sum += reservation.review.rating
      counter += 1
    end
    return false unless counter != 0

    (sum / counter * 100).truncate
  end
end
