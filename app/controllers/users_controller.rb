class UsersController < ApplicationController
  before_action :set_user, only: %i[follow unfollow]
  skip_before_action :authenticate_user!, only: %i[show index]

  def index
    @users = User.where.not(id: current_user.id)
  end

  # THERE MUST BE A BETTER WAY
  # def follow
  #   redirect_to user_path(@user) if current_user.follow(@user.id)
  # end

  # def unfollow
  #   redirect_to user_path(@user) if current_user.unfollow(@user.id)
  # end

  def show
    @user = User.find_by(id: params[:id])
    redirect_to user_path(current_user) if @user.blank?
    @coffees = Coffee.where(user_id: @user)
    @reviews = Review.where(user_id: @user)
    @likes = Like.where(user_id: @user)
  end

  def edit; end

  def update
    return redirect_to user_path(current_user) if current_user.update(user_params)

    render :edit
  end

  private def user_params
    params.require(:user).permit(:first_name, :about, :photo)
  end

  # I GUESS THERE'S NO NEED FOR THIS
  # private def set_user
  #   @user = User.find(params[:id])
  # end
end