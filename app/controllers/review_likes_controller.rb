class ReviewLikesController < ApplicationController
  def toggle
    @review = Review.find(params[:review_id])
    @review_like = ReviewLike.find_by(review: @review, user: current_user)
    @coffee = @review.coffee
    if @review_like
      @review_like.destroy
    else
      @review_like = ReviewLike.new
      @review_like.user = current_user
      @review_like.review = @review
      @review_like.save
    end
    respond_to do |format|
      format.html { redirect_to coffee_path(@coffee) }
      format.js
    end
  end
end
