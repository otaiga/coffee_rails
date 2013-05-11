require 'spec_helper'

describe Api::FoodController do

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
    before(:each) do
      @token = "TestAPIKey"
    end

    it "should check for json in request from base" do
      request.env['HTTP_X_API_TOKEN'] = @token
      get :index
      expected_msg = "Sorry the request must be in json"
      JSON.parse(response.body)["errors"].first.should == expected_msg
    end

    it "should provide a json response of food items" do
      FoodMenu.create!(name: "test_name", category: "test_category")
      request.env['HTTP_X_API_TOKEN'] = @token
      get :index, :format => :json
      JSON.parse(response.body).should == {"test_category"=>["test_name"]}
    end
  end
end