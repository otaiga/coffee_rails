CoffeeServer::Application.routes.draw do

  root :to => 'mains#index'

  devise_for :users

end
