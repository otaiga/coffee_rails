#This is a simple prize model.
#Only should ever be one record in here.
class Prize < ActiveRecord::Base
  attr_accessible :prize_stat, :prize
end
