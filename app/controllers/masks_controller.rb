class MasksController < ApplicationController
  def index
    real_parameters = params[:search]
    @masks = Mask.all
    return if real_parameters.nil?

    @location = real_parameters[:location]
    @start_time = Date.parse(real_parameters[:start_time]) unless real_parameters[:start_time].nil? || real_parameters[:start_time] == ""
    @end_time = Date.parse(real_parameters[:end_time]) unless real_parameters[:end_time].nil? || real_parameters[:end_time] == ""
    @size = real_parameters[:size] unless real_parameters[:size].nil? || real_parameters[:size] == ""

    if real_parameters[:start_time].present? && real_parameters[:location].present? && real_parameters[:size].present?
      @masks = Mask.joins(:user).where('users.address like ?', "%#{@location}%").where(['start_time < ? AND end_time > ?', @start_time, @end_time]).where(['size = ?', @size])

    elsif real_parameters[:start_time].present? && real_parameters[:location].present?
      @masks = Mask.joins(:user).where('users.address like ?', "%#{@location}%").where(['start_time < ? AND end_time > ?', @start_time, @end_time])

    elsif real_parameters[:location].present? && real_parameters[:size].present?
      @masks = Mask.joins(:user).where('users.address like ?', "%#{@location}%").where(['size = ?', @size])

    elsif real_parameters[:start_time].present? && real_parameters[:size].present?
      @masks = Mask.where(['start_time < ? AND end_time > ?', @start_time, @end_time]).where(['size = ?', @size])

    elsif real_parameters[:size].present?
      @masks = Mask.where(['size = ?', @size])

    elsif real_parameters[:start_time].present?
      @masks = Mask.where(['start_time < ? AND end_time > ?', @start_time, @end_time])

      # @masks_dates = @masks.where(['start_time < ? AND end_time > ?', parsed_time_start, parsed_time_end])
    elsif real_parameters[:location].present?
      @masks = Mask.joins(:user).where('users.address like ?', "%#{@location}%")

    # elsif real_parameters[:size].present? || real_parameters[:condition].present? || real_parameters[:price].present?
    #   sql_query = "
    #    CAST(size AS text) @@ :query \
    #    OR CAST(condition AS text) @@ :query \
    #    OR CAST(price AS text) ILIKE :query \
    #   "
    #   @masks = Mask.where(sql_query, query: "%#{real_parameters[:size]}%").where(sql_query, query: "%#{real_parameters[:condition]}%").where(sql_query, query: "#{real_parameters[:price]}")
    else
      @masks = Mask.all
    # end

    @users = User.geocoded # returns users with coordinates

    @markers = @users.map do |user|
      {
        lat: user.latitude,
        lng: user.longitude
        # infoWindow: render_to_string(partial: "info_window", locals: { user: user })

      }
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
