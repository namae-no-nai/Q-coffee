class PagesController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :set_coffee, only: [:roast, :sensory, :taste]

  def home
    @user = current_user
  end

  def roast
    @category_roast = Coffee.all.pluck(:roast).uniq
    @selection = []
    @category_roast.each do |roast|
      @selection << Coffee.category_search(roast)
    end
  end

  def sensory
    @category_sensory = Coffee.all.pluck(:sensory).uniq
    @selection = []
    @category_sensory.each do |sensory|
      @selection << Coffee.category_search(sensory)
    end
  end

  def taste
    @category_taste = Coffee.all.pluck(:taste).uniq
    @selection = []
    @category_taste.each do |taste|
      @selection << Coffee.category_search(taste)
    end
  end

  private

  def set_coffee
    @coffees = Coffee.all
  end
end
