Rails.application.routes.draw do
  get 'like/create'
  get 'like/destroy'
  devise_for :users
  root to: 'pages#home'

  get 'category/:category_name', to: 'coffees#category', as: 'category'
  get 'ocr', to: 'photos#ocr'
  get 'photo_search_path/:pic', to: 'photos#photo_search', as: 'photo_search'
  post 'photos', to: 'photos#create', as: 'photos'
  get 'liked_coffees/:id', to: 'coffees#liked_coffees', as: 'liked_coffees'
  get 'my_coffees/:user_id', to: 'coffees#my_coffees', as: 'my_coffees'
  get 'my_reviews/:id', to: 'coffees#my_reviews', as: 'my_reviews'
  get 'filter/:filter_param', to: 'pages#filter', as: 'filter'
  get 'map', to: 'coffees#coffee_map', as: 'coffee_map'


  resources :coffees do
    post 'toggle_like', to: 'likes#toggle'
    resources :reviews, only: [:create, :new, :update, :edit]
  end

  resources :users, only: [:index, :show, :update] do
    member do
      post :follow
      post :unfollow
    end
  end

  resources :reviews, only: [:index, :destroy] do
    post 'toggle_review_like', to: 'review_likes#toggle'
  end
end
