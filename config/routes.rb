CoffeeServer::Application.routes.draw do

  root :to => 'mains#index'

  devise_for :users

  resources :foods
  resources :drinks
  resources :hours

  namespace :api, :as => '' do
    scope "v1" do
       get "food_menu" => "food#index"
       get "drink_menu" => "drink#index"
    end
  end

end
