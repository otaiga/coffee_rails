class FoodMenu < ActiveRecord::Base
  attr_accessible :category, :name, :price

  def self.for_cat(cat)
    return unless cat
    self.where(category: cat)
  end
end