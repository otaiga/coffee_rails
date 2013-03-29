CoffeeServer::Application.routes.draw do

  root :to => 'mains#index'
  devise_for :users
  resources :foods
  resources :drinks
  resources :hours
  resources :events

  namespace :api, :as => '' do
    scope "v1" do
      get "food_menu" => "food#index"
      get "drink_menu" => "drink#index"
      get "opening_times" => "hour#index"
      get "events" => "event#index"
      get "friday_prize" => "friday_prize#index"
      post "friday_prize" => "friday_prize#create"
    end
  end

end
