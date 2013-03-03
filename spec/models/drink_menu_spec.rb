require 'spec_helper'

describe DrinkMenu do
  before(:all) do
    @new_item = {
      category: "cold_drinks",
      name: "can",
      price: "0.50"
    }
  end

  it "should be able to save a DrinkMenu item" do
    drink_item = DrinkMenu.new(@new_item)
    drink_item.save.should == true
  end

  it "should be able to update a DrinkMenu item" do
    drink_item = DrinkMenu.create!(@new_item)
    drink_item.update_attributes(name: "coffee").should == true
    drink_item.name.should == "coffee"
  end

  it "should be able to destroy a DrinkMenu item" do
    drink_item = DrinkMenu.create!(@new_item)
    expect {drink_item.destroy}.to change(DrinkMenu, :count).by(-1)
  end
end
