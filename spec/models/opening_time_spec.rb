require 'spec_helper'

describe OpeningTime do
  it "should be able to save an opening time" do
    opening_time = OpeningTime.new(weekday: "Monday-Friday", open_time: "08:00am", close_time: "18:00pm")
    opening_time.save.should == true
  end

  it "should be able to update an opening time" do
    opening_time = OpeningTime.create!(weekday: "Monday-Friday", open_time: "08:00am", close_time: "18:00pm")
    opening_time.update_attributes(open_time: "9:00am").should == true
    opening_time.open_time.should == "9:00am"
  end

  it "should be able to destroy an opening time" do
    opening_time = OpeningTime.create!(weekday: "Monday-Friday", open_time: "08:00am", close_time: "18:00pm")
    expect {opening_time.destroy}.to change(OpeningTime, :count).by(-1)
  end
end
