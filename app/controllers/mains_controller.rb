class MainsController < ApplicationController
  before_filter :authenticate_user!

# TODO (tests for models first), Group these by category (food and drink)
  def index
    @food_menu = FoodMenu.all
    @drinks_menu = DrinkMenu.all
    @events = Event.all
    @openning_times = OpenningTime.all
  end

end
