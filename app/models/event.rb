#Event model for all event items
class Event < ActiveRecord::Base
  attr_accessible :title, :description

  def self.hashed_response
    hash_resp = {}
    self.all.each do |event|
      event_sym = event.title.downcase.gsub(" ", "_").to_sym
      hash_resp.merge!({
        event_sym => event.description
        })
    end
    hash_resp
  end
end
