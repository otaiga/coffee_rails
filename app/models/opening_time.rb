class OpeningTime < ActiveRecord::Base
  attr_accessible :weekday, :open_time, :close_time
end