class MasksController < ApplicationController
  def index
    # if params[:query].present? # include? (:location, :start_time, :end_time)
    #   sql_query = "
    #     description ILIKE :query \
    #     OR start_time ILIKE :query \
    #     OR end_time ILIKE :query \
    #   "
    #   @masks = Mask.where(sql_query, query: "%#{params[:query]}%")
    if params[:query].present?
      @masks = Mask.where("description ILIKE ?", "%#{params[:query]}%")
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

  # private

  # def simple_mask_params
  #   params.require(:mask).permit(:description, :start_time, :end_time)
  # end

  # def complex_mask_params
  #   params.require(:mask).permit(:description, :condition, :size, :start_time, :end_time, :price)
  # end
end
