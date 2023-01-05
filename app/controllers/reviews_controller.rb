class ReviewsController < ApplicationController
  before_action :set_coffee, only: %i[index create edit update]
  before_action :set_review, only: %i[edit update destroy]
  skip_before_action :authenticate_user!, only: %i[index]
  before_action :edit_permit, only: :edit

  def index
    @reviews = Review.where(params[:coffee_id])
  end

  def my_reviews
    @user = User.find(params[:user_id])
    @reviews = Review.where(user: @user)
  end

  def new
    @review = Review.new
  end

  def create
    @user = current_user
    @review = Review.new(reviews_params)
    @review.coffee = @coffee
    @review.user = @user
    if @review.save
      redirect_to coffee_path(@coffee)
    else
      render :new
    end
  end

  def edit; end

  def update
    redirect_to coffee_path(@review.coffee) if @review.update(reviews_params)

    render :edit
  end

  def destroy
    @review.destroy
    redirect_to coffee_path(@review.coffee)
  end

  private def reviews_params
    params.require(:review).permit(:content, :rating)
  end

  private def set_coffee
    @coffee = Coffee.find(params[:coffee_id])
  end

  private def set_review
    @review = Review.find(params[:id])
  end

  private def edit_permit
    redirect_to coffee_path(@coffee) unless current_user.id == @review.user_id
  end
end