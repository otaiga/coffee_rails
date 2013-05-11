require 'spec_helper'

describe Api::HourController do

  context "api checks" do

    it "should check for presence of an api key" do
      get :index, :format => :json
      expected_msg = "HTTP Token: Access denied."
      JSON.parse(response.body)["errors"].first.should == expected_msg
    end

    it "should check for correct api key" do
      request.env['HTTP_X_API_TOKEN'] = "wrong_key"
      get :index, :format => :json
      expected_msg = "HTTP Token: Access denied."
      JSON.parse(response.body)["errors"].first.should == expected_msg
    end
  end

  context "with api key" do
    before(:all) do
      @test_data = {
        weekday: "Monday-Friday",
        open_time: "09:00",
        close_time: "14:00"
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
      OpeningTime.create!(@test_data)
      request.env['HTTP_X_API_TOKEN'] = @token
      get :index, :format => :json
      JSON.parse(response.body).should == {"monday_to_friday"=>"09:00 - 14:00"}
    end
  end
end