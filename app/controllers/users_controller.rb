class UsersController < ApplicationController
  before_action :set_user, only: %i[follow unfollow]
  skip_before_action :authenticate_user!, only: %i[show index]

  def index
    @users = User.where.not(id: current_user.id)
  end

  def follow
    redirect_to user_path(@user) if current_user.follow(@user.id)
  end

  def unfollow
    redirect_to user_path(@user) if current_user.unfollow(@user.id)
  end

  def show
    @user = User.find(params[:id])
    @coffees = Coffee.where(user_id: @user)
    @reviews = Review.where(user_id: @user)
    @likes = Like.where(user_id: @user)
  end

  def edit
    current_user
  end

  def update
    # authorize @user
    if current_user.update(user_params)
      redirect_to user_path(current_user)
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :about, :photo)
  end

  def set_user
    @user = User.find(params[:id])
  end
end