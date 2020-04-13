class PagesController < ApplicationController
  def home
  end

  def dashboard
    @user = current_user
    @reservations_renters = Reservation.where(user_id: current_user.id)
    @reservations_owners = Reservation.where(mask_id: current_user.masks)
  end
end
