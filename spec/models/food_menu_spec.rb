require 'spec_helper'

describe FoodMenu do
  before(:all) do
    @food_item = {
      category: "jacket_potatoes",
      name: "tuna",
      price: "1.08"
    }
  end
  it "should be able to save a FoodMenu item" do
    food_item = FoodMenu.new(@food_item)
    food_item.save.should == true
  end

  it "should be able to update a FoodMenu item" do
    food_item = FoodMenu.create!(@food_item)
    food_item.update_attributes(name: "cheese").should == true
    food_item.name.should == "cheese"
  end

  it "should be able to destroy a FoodMenu item" do
    food_item = FoodMenu.create!(@food_item)
    expect {food_item.destroy}.to change(FoodMenu, :count).by(-1)
  end
end
