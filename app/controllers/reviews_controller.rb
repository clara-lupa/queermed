class ReviewsController < ApplicationController
  def new
    @review = Review.all
  end

  def create
    @review = Review.new(review_params)

  end


  private

  def review_params
    params.require(:review).permit(:content)
  end
end
