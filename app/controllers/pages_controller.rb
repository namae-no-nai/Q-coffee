class PagesController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :set_coffee, only: %i[filter]

  def home
    @user = current_user
  end

  def filter
    @categories = Coffee.all.pluck(filter_param.to_sym).uniq
    @selection = @categories.map { |category| Coffee.category_search(category) }
  end

  private def set_coffee
    @coffees = Coffee.all
  end

  private def filter_param
    return params[:filter_param] if %w[roast sensory taste].include?(params[:filter_param])

    redirect_to current_path, alert: 'Página não existente'
  end
end
