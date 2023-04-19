Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "foods#index"

  resources :foods, only: [:index, :new, :create, :destroy]
  resources :recipes, only: [:index, :show, :new, :create, :destroy]
  resources :recipe_foods, only: [:index]
  resources :public_recipes, only: [:index]
  get '/shopping_list', to: 'recipes#shopping_list', as: 'shopping_list'
end
