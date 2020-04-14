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
    @review = Review.new(review_params)
    @review.user = current_user
    @review.save
    redirect_to pages_reviews_path
  end

  private

  def review_params
    params.require(:review).permit(:content, :rating, :reviewable_id, :reviewable_type)
  end
end
