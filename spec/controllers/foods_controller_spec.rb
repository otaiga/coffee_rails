require 'spec_helper'

describe FoodsController do
  context "as an authenticated user" do
    before(:each) do
      sign_in given_user
    end

    it "should be able to access index" do
      get :index
      response.should be_success
      assigns(:food_items).should == FoodMenu.all
    end

  end

  context "not as an authenticated user" do

    it "should redirect to sign in on index" do
      get :index
      response.should redirect_to new_user_session_path
    end

  end

end
