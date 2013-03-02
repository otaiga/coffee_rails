#Drink model for all drink items
class DrinkMenu < ActiveRecord::Base
  attr_accessible :category, :name, :price
end
