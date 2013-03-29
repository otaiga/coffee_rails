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

    context "with json format" do
      it "should check for email present" do
        message = "Email must be present and should be Friday"
        post :create, :format => :json
        reply = JSON.parse(response.body)
        reply["errors"].first.should == message
      end

      it "should check for Friday" do
        message = "Email must be present and should be Friday"
        Timecop.freeze(Date.parse("04/04/2013"))
        post :create, :email => "testuser@example.com", :format => :json
        reply = JSON.parse(response.body)
        reply["errors"].first.should == message
        Timecop.return
      end

      it "should provide a response with prize result" do
        Timecop.freeze(Date.parse("05/04/2013"))
        post :create, :email => "testuser@example.com", :format => :json
        reply = JSON.parse(response.body)
        reply["prize"].should == "1 Small Coffee"
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
      it "should respond with status of prize_day enabled" do
        get :index, :format => :json
        reply = JSON.parse(response.body)
        reply["prize_status"].should == "enabled"
      end
    end

  end
end