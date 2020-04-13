class ReviewsController < ApplicationController
  def new
    @review = Review.new
    puts params
  end

  def create
  end


end
