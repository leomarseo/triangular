class MasksController < ApplicationController
  def index
    # if params[:query].present? # include? (:location, :start_time, :end_time)
    #   sql_query = "
    #     description ILIKE :query \
    #     OR start_time ILIKE :query \
    #     OR end_time ILIKE :query \
    #   "
    #   @masks = Mask.where(sql_query, query: "%#{params[:query]}%")
    if params[:location].present? || params[:start_time].present? || params[:end_time].present?
      sql_query = " \
        users.address @@ :query \
        OR CAST(masks.start_time AS text) @@ :query \
        OR CAST(masks.end_time AS text) @@ :query \
        "
        # raise
        search = params[:location] + " " + params[:start_time] + " " + params[:end_time]
      @masks = Mask.joins(:user).where(sql_query, query: "%#{search}%")
    # elsif params[:query].include? (:size, :condition, :price)
    #   sql_query = "
    #     masks.size @@ :query \
    #     OR masks.condition @@ :query \
    #     OR masks.price @@ :query \
    #   "
    #   @masks = Mask.where(sql_query, query: "%#{complex_mask_params}%")
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
    mask.user.address = current_user.address
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

  # def simple_mask_params
  #   params.require(:mask).permit(:description, :start_time, :end_time)
  # end

  def mask_params
    params.require(:mask).permit(:name, :description, :condition, :size, :start_time, :end_time, :price, :photo)
  end
end
