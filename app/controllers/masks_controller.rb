class MasksController < ApplicationController
  def index
    @masks = Mask.all
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

  def mask_params
    params.require(:mask).permit(:description, :condition, :size, :start_time, :end_time, :price)
  end
end
