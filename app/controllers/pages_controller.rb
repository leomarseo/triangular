class PagesController < ApplicationController
  def home
  end

  def dashboard
    @user = current_user
  end

  def confirm_reservation(reservation)
    reservation.update(confirmed: true)
  end

end
