#Drinks controller to be used by admin
#To create drink items
class DrinksController < ApplicationController
  before_filter :authenticate_user!

  def index
    @categories = DrinkMenu.avail_categories
  end

  def edit
    @drink_item = DrinkMenu.find(params[:id])
  end

  def new
    @drink_item = DrinkMenu.new
  end

  def create
    @drink_item = DrinkMenu.new(params[:drink_menu])
    if @drink_item.save
      redirect_to drinks_path
    else
      redirect_to drinks_path
    end
  end

  def update
    @drink_item = DrinkMenu.find(params[:id])
    if @drink_item.update_attributes(params[:drink_menu])
      redirect_to drinks_path
    end
  end

  def destroy
    @drink_item = DrinkMenu.find(params[:id])
    if @drink_item.destroy
      redirect_to drinks_path
    end
  end
end
