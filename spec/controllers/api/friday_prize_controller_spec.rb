require 'spec_helper'

describe Api::FridayPrizeController do

  it "should check for json in request from base" do
    post :create
    expected_msg = "Sorry the request must be in json"
    JSON.parse(response.body)["errors"].first.should == expected_msg
  end

  it "should provide a response with prize result" do
    pending("TODO")
  end
end