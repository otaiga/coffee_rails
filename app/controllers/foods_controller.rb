class FoodsController < ApplicationController

  def index
    @categories = FoodMenu.avail_categories
  end

  def edit
    @food_item = FoodMenu.find(params[:id])
  end

  def new
    @food_item = FoodMenu.new
  end

  def create
    @food_item = FoodMenu.new(params[:food_menu])
    if @food_item.save
      redirect_to foods_path
    else
      redirect_to foods_path
    end
  end

  def update
    @food_item = FoodMenu.find(params[:id])
    if @food_item.update_attributes(params[:food_menu])
      redirect_to foods_path
    end
  end

  def destroy
    @food_item = FoodMenu.find(params[:id])
    if @food_item.destroy
      redirect_to foods_path
    end
  end

end
