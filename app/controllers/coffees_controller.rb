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
    @average = calculate_average
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
    redirect_to coffee_path(@coffee) if @coffee.save

    render :new
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

  # Major reimplementation
  # def liked_coffees
  #   @user = User.find(params[:id])
  #   @likes = Like.where(user: @user)
  # end

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
    # Implements map
    # @markers = @coffees.geocoded.map do |coffee|
    #   {
    #     lat: coffee.latitude,
    #     lng: coffee.longitude,
    #     infoWindow: render_to_string(partial: "info_window", locals: { coffee: coffee }),
    #     image_url: helpers.asset_url('icon.png')
    #   }
    # end
  end

  private def coffee_params
    params.require(:coffee).permit(:name, :brand,
                                   :farm, :roast, :sensory,
                                   :origin_id, :taste,
                                   :store)
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