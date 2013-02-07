class FoodMenu < ActiveRecord::Base
  attr_accessible :category, :name, :price
end