class ReservationsController < ApplicationController
  def index
    @reservations = Reservation.where(user_id: current_user.id)
  end

  def show
    @reservation = Reservation.find(params[:id])
  end

  def new
    @mask = Mask.find(params[:id])
    @reservation = Reservation.new
  end

  def create
    @reservation = Reservation.new(reservation_params)
    @reservation.user = current_user.id
    @reservation.mask = params[:id]
    @reservation.save
    redirect_to reservations_path
  end

  def edit

  end

  def update
  end

  private

  def reservation_params
    params.require(:reservation).include(:mask, :user, :start_time, :end_time)
  end

end
