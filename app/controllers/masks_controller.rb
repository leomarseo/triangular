class MasksController < ApplicationController
  def index
    @masks = Mask.all
    @masks = Mask.where(mask_params) if params['mask'].present?
  end

  def new
    @mask = Mask.new
  end

  def create
    mask = Mask.new(mask_params)
    mask.user = current_user
    mask.save
    redirect_to pages_dashboard_path
  end

  def show
    @mask = Mask.find(params[:id])
  end

  def edit
    @mask = Mask.find(params[:id])
  end

  def update
    @mask = Mask.find(params[:id])
    @mask.update(mask_params)
    redirect_to pages_dashboard_path
  end

  private

  def mask_params
    params.require(:mask).permit(:description, :condition, :size, :start_time, :end_time, :price)
  end
end
