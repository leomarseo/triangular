class MasksController < ApplicationController
  def index
    @masks = Mask.all
    @masks = Mask.where(mask_params) if params['mask'].present?
  end

  def new
    @mask = Mask.new
  end

  def create
    fake_user = User.find(1)
    mask = Mask.new(mask_params)
    mask.user_id = fake_user.id
    mask.save
    redirect_to masks_path
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
