class ReservationsController < ApplicationController

  # index no longer necessary - being moved to dashboard viewer
  # def index
  #   @reservations = Reservation.where(user_id: current_user.id)
  # end

  def show
    @reservation = Reservation.find(params[:id])
  end

  def new
    @mask = Mask.find(params[:mask_id])
    @reservation = Reservation.new
  end

  def create
    @reservation = Reservation.new(reservation_params)
    @reservation.user = current_user
    @reservation.mask_id = params[:mask_id]
    @reservation.save
    redirect_to pages_dashboard_path
  end

  def edit

  end

  def update
  end

  private

  def reservation_params
    params.require(:reservation).permit(:mask, :user, :start_time, :end_time)
  end

end
