class CoffeesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show category search coffee_map]
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
    average
  end

  def new
    @coffee = Coffee.new
  end

  def my_coffee
    @like = Like.where(user_id: current_user)
    @coffes = @like.coffee
  end

  def create
    @coffee = Coffee.new(coffee_params)
    @coffee.user = current_user
    @coffee.address = params[:coffee][:address]
    if @coffee.save
      redirect_to coffee_path(@coffee)
    else
      render :new
    end
  end

  def edit; end

  def update
    if @coffee.update(coffee_params)
      redirect_to coffee_path(@coffee)
    else
      render :edit
    end
  end

  def destroy
    @coffee.destroy
    redirect_to user_path(current_user)
  end

  def category
    @coffees = Coffee.category_search(params[:category_name])
  end

  def search
    if params[:query].present?
      @coffees = Coffee.global_search(params[:query])
    else
      @coffees = Coffee.all
    end
  end

  def liked_coffees
    @user = User.find(params[:id])
    @likes = Like.where(user: @user)
  end

  def my_reviews
    @user = User.find(params[:id])
    @reviews = Review.where(user: @user)
  end

  def my_coffees
    @user = User.find(params[:id])
    @coffees = Coffee.where(user: @user)
  end

  def coffee_map
    @coffees = Coffee.all
    @markers = @coffees.geocoded.map do |coffee|
      {
        lat: coffee.latitude,
        lng: coffee.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { coffee: coffee }),
        image_url: helpers.asset_url('icon.png')
      }
    end
  end

  private

  def coffee_params
    params.require(:coffee).permit(:name, :brand,
                                   :farm, :roast, :sensory,
                                   :origin_id, :taste,
                                   :photo, :store)
  end

  def set_coffee
    @coffee = Coffee.find(params[:id])
    @origin = Origin.all
  end

  def coffee_settings
    @roast = ['clara', 'média', 'escura']
    @sensory = ['frutado', 'achocolatado', 'floral']
    @taste = ['doce', 'ácido', 'equilibrado', 'amargo']
    @origin = Origin.all
  end

  def average
    @average = 0
    @reviews = Review.where(coffee_id: @coffee)
    if @reviews.count != 0
      @reviews.each do |review|
        @average += review.rating
      end
      @average_float = @average.to_f / @reviews.count
      @average /= @reviews.count
    else
      @average = 0
      @average_float = @average.to_f
    end
  end

  def edit_permit
    unless current_user.id == @coffee.user_id
      redirect_to coffee_path(@coffee)
    end
  end
end