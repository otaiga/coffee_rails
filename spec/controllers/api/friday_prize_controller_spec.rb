require 'spec_helper'

describe Api::FridayPrizeController do

  describe "create prize" do

    context "not json format" do

      it "should check for json in request from base" do
        post :create
        expected_msg = "Sorry the request must be in json"
        JSON.parse(response.body)["errors"].first.should == expected_msg
      end
    end

    context "api checks" do

      it "should check for presence of an api key" do
        post :create, :format => :json
        expected_msg = "HTTP Token: Access denied."
        JSON.parse(response.body)["errors"].first.should == expected_msg
      end

      it "should check for correct api key" do
        request.env['HTTP_X_API_TOKEN'] = "wrong_key"
        post :create, :format => :json
        expected_msg = "HTTP Token: Access denied."
        JSON.parse(response.body)["errors"].first.should == expected_msg
      end
    end

    context "with json format" do
      before(:each) do
        @token = "TestAPIKey"
      end

      it "should check for status" do
        Prize.create!(
          prize_stat: "disabled",
          prize: "test_prize"
          )
        message = "Prize Status not enabled"
        request.env['HTTP_X_API_TOKEN'] = @token
        post :create, :format => :json
        reply = JSON.parse(response.body)
        reply["errors"].first.should == "Prize Status not enabled"
      end

      it "should provide a response of not enabled if no prize" do
        Prize.create!(
          prize_stat: "enabled",
        )
        request.env['HTTP_X_API_TOKEN'] = @token
        post :create, :format => :json
        reply = JSON.parse(response.body)
        reply["errors"].first.should == "Prize Status not enabled"
      end

      it "should provide a response of already taken" do
        Prize.create!(
          prize_stat: "enabled",
          prize: "already taken"
          )
        request.env['HTTP_X_API_TOKEN'] = @token
        post :create, :format => :json
        reply = JSON.parse(response.body)
        reply["taken_message"].should == "Sorry prize has been won today"
      end

      it "should return prize if checks pass" do
        Prize.create!(
          prize_stat: "enabled",
          prize: "test_prize"
          )
        request.env['HTTP_X_API_TOKEN'] = @token
        post :create, :format => :json
        reply = JSON.parse(response.body)
        reply.should have(1).items
      end
    end
  end

  describe "check if prize enabled" do

    context "not json format" do
      it "should check for json in request from base" do
        get :index
        expected_msg = "Sorry the request must be in json"
        JSON.parse(response.body)["errors"].first.should == expected_msg
      end
    end

    context "with json format" do
      before(:each) do
        @token = "TestAPIKey"
      end

      it "should respond with status of prize_day enabled" do
        Prize.create!(prize_stat: "enabled")
        request.env['HTTP_X_API_TOKEN'] = @token
        get :index, :format => :json
        reply = JSON.parse(response.body)
        reply["prize_status"].should == "enabled"
      end
    end

  end
end