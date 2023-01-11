class CoffeesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show category]
  before_action :set_coffee, only: %i[show edit update destroy]
  before_action :coffee_settings, only: %i[new create edit update]
  before_action :edit_permit, only: :edit

  def index
    @coffees = Coffee.all
    @origin = Origin.all
  end

  def show
    @reviews = Review.where(coffee_id: @coffee)
    @review = Review.new
    @like = Like.where(user_id: current_user, coffee_id: @coffee)
    @average = calculate_average
  end

  def new
    @coffee = Coffee.new
  end

  # My liked coffees?
  # def my_coffee
  #   @like = Like.where(user_id: current_user)
  #   @coffes = @like.coffee
  # end

  def create
    @coffee = Coffee.new(coffee_params)
    @coffee.user = current_user
    @coffee.address = params[:coffee][:address]
    redirect_to coffee_path(@coffee) if @coffee.save

    render :new
  end

  def edit; end

  def update
    redirect_to coffee_path(@coffee) if @coffee.update(coffee_params)

    render :edit
  end

  def destroy
    @coffee.destroy
    redirect_to user_path(current_user)
  end

  def category
    @coffees = Coffee.category_search(params[:category_name])
  end

  def search
    params[:query].present? ? @coffees = Coffee.global_search(params[:query]) : @coffees = Coffee.all
  end

  # Major reimplementation
  # def liked_coffees
  #   @user = User.find(params[:id])
  #   @likes = Like.where(user: @user)
  # end

  def my_coffees
    @user = User.find(params[:user_id])
    @coffees = Coffee.where(user: @user)
  end

  def coffee_map
    @coffees = Coffee.all
    # Implements map
  end

  private def coffee_params
    params.require(:coffee).permit(:name, :brand,
                                   :farm, :roast, :sensory,
                                   :origin_id, :taste,)
  end

  private def set_coffee
    @coffee = Coffee.find(params[:id])
    @origin = Origin.all
  end

  private def coffee_settings
    @roast = ['clara', 'média', 'escura']
    @sensory = ['frutado', 'achocolatado', 'floral']
    @taste = ['doce', 'ácido', 'equilibrado', 'amargo']
    @origin = Origin.all
  end

  private def calculate_average
    reviews = Review.where(coffee_id: @coffee).pluck(:rating)
    return 'Esse café não tem reviews ainda' if reviews.empty?

    reviews.reduce(:+)/reviews.size.to_f
  end

  private def edit_permit
    return redirect_to coffee_path(@coffee) unless current_user.id == @coffee.user_id
  end
end