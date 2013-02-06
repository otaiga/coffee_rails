require 'spec_helper'

describe OpeningTime do
  it "should be able to save an opening time" do
    opening_time = OpeningTime.new(weekday: "Monday-Friday", open_time: "08:00am", close_time: "18:00pm")
    opening_time.save.should == true
  end
end
