CoffeeServer::Application.routes.draw do

  root :to => 'mains#index'

  devise_for :users

  resources :foods
  resources :drinks

  namespace :api, :as => '' do
    scope "v1" do
       get "food_menu" => "food#index"
    end
  end

end
