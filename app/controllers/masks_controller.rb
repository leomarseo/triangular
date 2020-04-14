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
        # if params[:query].present? # include? (:location, :start_time, :end_time))
    #   sql_query = "
    #     description ILIKE :query \
    #     OR start_time ILIKE :query \
    #     OR end_time ILIKE :query \
    #   "
    #   @masks = Mask.where(sql_query, query: "%#{params[:query]}%")
    # if params[:location].present?
    #   sql_query = " \
    #     users.address @@ :query \
    #     OR CAST(masks.start_time AS text) @@ :query \
    #     OR CAST(masks.end_time AS text) @@ :query \
    #   "
    #   @masks = Mask.joins(:user).where(sql_query, query: "%#{params[:location]}%")
    # elsif params[:start_time].present?
    #   sql_query = " \
    #     users.address @@ :query \
    #     OR CAST(masks.start_time AS text) @@ :query \
    #     OR CAST(masks.end_time AS text) @@ :query \
    #   "
    #   @masks = Mask.joins(:user).where(sql_query, query: "%#{params[:start_time]}%")
    # elsif params[:end_time].present?
    #   sql_query = " \
    #     users.address @@ :query \
    #     OR CAST(masks.start_time AS text) @@ :query \
    #     OR CAST(masks.end_time AS text) @@ :query \
    #   "
    #   @masks = Mask.joins(:user).where(sql_query, query: "%#{params[:end_time]}%")
    # elsif params[:size].present?
    #   sql_query = "
    #     CAST(size AS text) @@ :query \
    #     OR CAST(condition AS text) @@ :query \
    #     OR CAST(price AS text) ILIKE :query \
    #   "
    #   @masks = Mask.where(sql_query, query: "%#{params[:size]}%")
    # elsif params[:condition].present?
    #   sql_query = "
    #     CAST(size AS text) @@ :query \
    #     OR CAST(condition AS text) @@ :query \
    #     OR CAST(price AS text) ILIKE :query \
    #   "
    #   @masks = Mask.where(sql_query, query: "%#{params[:condition]}%")
    # elsif params[:price].present?
    #   sql_query = "
    #     CAST(size AS text) @@ :query \
    #     OR CAST(condition AS text) @@ :query \
    #     OR CAST(price AS text) ILIKE :query \
    #   "
    #   @masks = Mask.where(sql_query, query: "%#{params[:price]}%")
    # else
    #   @masks = Mask.all
    # end
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
