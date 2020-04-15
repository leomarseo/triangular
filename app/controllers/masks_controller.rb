class MasksController < ApplicationController
  def index
    if params[:start_time].present? || params[:end_time].present? || params[:location].present?
      parsed_time_start = Date.parse(params[:start_time])
      parsed_time_end = Date.parse(params[:end_time])
      # @masks = Mask.where(:start_time => parsed_date)
      # @masks = Mask.where([:start_time >= parsed_time_start] && [ :end_time <= parsed_time_end])

      @masks = Mask.joins(:user).where('users.address like ?', "%#{params[:location]}%").where(['start_time < ? AND end_time > ?', parsed_time_start, parsed_time_end])
      # @masks_dates = @masks.where(['start_time < ? AND end_time > ?', parsed_time_start, parsed_time_end])
    elsif params[:size].present? || params[:condition].present? || params[:price].present?
      sql_query = "
       CAST(size AS text) @@ :query \
       OR CAST(condition AS text) @@ :query \
       OR CAST(price AS text) ILIKE :query \
      "
      @masks = Mask.where(sql_query, query: "%#{params[:size]}".where(sql_query, query: "%#{params[:condition]}").where(sql_query, query: "%#{params[:price]}"))
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
