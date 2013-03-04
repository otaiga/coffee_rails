require 'spec_helper'

describe Api::DrinkController do

  it "should check for json in request from base" do
    get :index
    expected_msg = "Sorry the request must be in json"
    JSON.parse(response.body)["errors"].first.should == expected_msg
  end

  it "should provide a json response of drink items" do
    DrinkMenu.create!(name: "test_name", category: "test_category")
    get :index, :format => :json
    JSON.parse(response.body).should == {"test_category"=>["test_name"]}
  end
end