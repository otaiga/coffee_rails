#Event model for all event items
class Event < ActiveRecord::Base
  attr_accessible :title, :description
end
