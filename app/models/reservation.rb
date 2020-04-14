require 'date'

class Reservation < ApplicationRecord
  belongs_to :mask
  belongs_to :user
  has_one :review, as: :reviewable
  validates_presence_of :mask, :user, :start_time, :end_time
  validates :confirmed, default: false

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
