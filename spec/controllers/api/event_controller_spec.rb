require 'spec_helper'

describe Api::EventController do
    before(:all) do
      @test_data = {
        title: "test event",
        description: "test data"
      }
      @token = "TestAPIKey"
    end

  it "should check for json in request from base" do
    request.env['HTTP_X_API_TOKEN'] = @token
    get :index
    expected_msg = "Sorry the request must be in json"
    JSON.parse(response.body)["errors"].first.should == expected_msg
  end

  it "should provide a json response of food items" do
    Event.create!(@test_data)
    request.env['HTTP_X_API_TOKEN'] = @token
    get :index, :format => :json
    JSON.parse(response.body).should == {"test_event"=>"test data"}
  end
end