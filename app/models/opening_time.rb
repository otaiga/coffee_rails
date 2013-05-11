#OpeningTime model for opening times
class OpeningTime < ActiveRecord::Base
  attr_accessible :weekday, :open_time, :close_time
  validates_uniqueness_of :weekday

  def self.hashed_response
    hash_resp = {}
    self.all.each do |o_time|
      week_sym = o_time.weekday.downcase.gsub("-", "_to_").to_sym
      hash_resp.merge!({
        week_sym => times_for_week(o_time)
        })
    end
    hash_resp
  end

private

  def self.times_for_week(o_time)
    "#{o_time.open_time} - #{o_time.close_time}"
  end
end