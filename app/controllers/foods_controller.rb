class FoodsController < ApplicationController

  def index
    @food_items = FoodMenu.all
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

  end

  def destroy

  end

end
