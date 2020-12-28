class ReviewsController < ApplicationController
  def create
    @review = Review.new(review_params)
    @review.user = current_user
    @provider = Provider.find(params[:provider_id])
    @review.provider = @provider
    if @review.save
      redirect_to provider_path(@provider)
    else
      render "providers/show"
    end
  end

  def update
    @restaurant = Restaurant.find(params[:id])
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
  end

  private

  def review_params
    params.require(:review).permit(:content)
  end
end
