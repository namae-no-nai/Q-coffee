class PagesController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :set_coffee, only: [:roast, :sensory, :taste]

  def home
    @user = current_user
  end

  def roast
    filter('roast')
  end

  def sensory
    filter('sensory')
  end

  def taste
    filter('taste')
  end

  private def filter(filter_param)
    @filtered_category = Coffee.all.pluck(filter_param.to_sym).uniq
    @selection = []
    @filtered_category.each do |filter_param|
      @selection << Coffee.category_search(filter_param)
    end
  end

  private def set_coffee
    @coffees = Coffee.all
  end
end
