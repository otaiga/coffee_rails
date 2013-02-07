require 'spec_helper'

describe Event do
  it "should be able to save a Event item" do
    event_item = Event.new(title: "Big Ball", description: "black tie")
    event_item.save.should == true
  end

  it "should be able to update a Event item" do
    event_item = Event.create!(title: "Big Ball", description: "black tie")
    event_item.update_attributes(description: "casual").should == true
    event_item.description.should == "casual"
  end

  it "should be able to destroy a Event item" do
    event_item = Event.create!(title: "Big Ball", description: "black tie")
    expect {event_item.destroy}.to change(Event, :count).by(-1)
  end
end
