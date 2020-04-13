require 'date'

class Reservation < ApplicationRecord
  belongs_to :mask
  belongs_to :user
  has_many :reviews, as: :reviewable
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :active, default: true

  def reservation_status(start_date, end_date)
    date_today = DateTime.current.beginning_of_day
    if date_today > end_date
      'expired'
    elsif (date_today <= end_date) && (date_today >= start_date)
      'active'
    else
      'inactive'
    end
  end
end
