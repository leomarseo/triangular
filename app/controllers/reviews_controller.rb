class ReviewsController < ApplicationController
  def new
    @review = Review.new
    if (current_user.masks.find_by id: params['mask_id']).nil?
      # customer
      @review.reviewable = Mask.find(params['mask_id'])
    else
      # owner
      @review.reviewable = Reservation.find(params['reservation_id'])
    end
  end

  def create
    @review = Review.create(review_params)
    redirect_to pages_dashboard_path
  end

  private

  def review_params
    params.require(:review).permit(:content, :rating, :reviewable_id, :reviewable_type)
  end
end
