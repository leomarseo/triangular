class MasksController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    real_parameters = params[:search]
    @masks = Mask.all
    @markers = []
    return if real_parameters.nil?

    @location = real_parameters[:location].downcase.capitalize unless real_parameters[:location].nil? || real_parameters[:location] == ""

    if !real_parameters[:start_time].nil? && real_parameters[:start_time] != ""
      @full_time = real_parameters[:start_time]
      @start_time = Date.parse(@full_time.chars.first(10).join)
      @end_time = Date.parse(@full_time.chars.last(10).join)
    elsif !@range_time.nil?
      @start_time = Date.parse(@range_time.chars.first(10).join)
      @end_time = Date.parse(@range_time.chars.last(10).join)
    end

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

    elsif real_parameters[:location].present?
      @masks = Mask.joins(:user).where('users.address like ?', "%#{@location}%")

    else
      @masks = Mask.all
    end


    users = @masks.map { |mask| mask.user }.uniq
    unless users.nil?
      @users = User.where(id: users.map(&:id)).geocoded
      @markers = @users.map do |user|
        {
          lat: user.latitude,
          lng: user.longitude
          # infoWindow: render_to_string(partial: "info_window", locals: { user: user })
        }
      end
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
