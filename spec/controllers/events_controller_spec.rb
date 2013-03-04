require 'spec_helper'

describe EventsController do
  context "as an authenticated user" do
    before(:each) do
      sign_in given_user
    end

    before(:all) do
      @test_data = {
        title: "test_item",
        description: "test_event_details"
      }
    end

    it "should be able to access index" do
      get :index
      response.should be_success
      assigns(:events).should == Event.all
    end

    it "should be able to create an event item" do
      post :create, event: @test_data
      response.should redirect_to events_path
      Event.count.should == 1
    end

    it "should be able to edit a drink item" do
      Event.create!(@test_data)
      get :edit, id: Event.last.id
      response.should be_success
      assigns(:event).should == Event.last
    end

    it "should be able to update a drink item" do
      Event.create!(@test_data)
      put :update, {id: Event.last.id, event: {title: "new_name"}}
      response.should redirect_to events_path
      Event.last.title.should == "new_name"
    end

    it "should be able to destroy a drink item" do
      Event.create!(@test_data)
      delete :destroy, id: Event.last.id
      response.should redirect_to events_path
      Event.all.empty?.should == true
    end

  end

  context "not as an authenticated user" do

    it "should redirect to sign in on index" do
      get :index
      response.should redirect_to new_user_session_path
    end

  end
end
