class MasksController < ApplicationController
  def index
    if params['mask'].present?
      @masks = Mask.where(mask_params)
    else
      @masks = Mask.all
    end
  end

  def new
    @mask = Mask.new
  end

  def create
    mask = Mask.new(mask_params)
    mask.user = current_user
    mask.save
    redirect_to pages_masks_path
  end

  def show
    @mask = Mask.find(params[:id])
    @reviews = Review.all
    @reservation = Reservation.new
  end

  def edit
    @mask = Mask.find(params[:id])
  end

  def update
    @mask = Mask.find(params[:id])
    @mask.update(mask_params)
    redirect_to pages_masks_path
  end

  def destroy
    @mask = Mask.find(params[:id])
    @mask.update(deleted: true)
    redirect_to pages_masks_path
  end

  private

  def mask_params
    params.require(:mask).permit(:name, :description, :condition, :size, :start_time, :end_time, :price, :photo)
  end
end
