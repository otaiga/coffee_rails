require 'spec_helper'

describe DrinksController do
  context "as an authenticated user" do
    before(:each) do
      sign_in given_user
    end

    it "should be able to access index" do
      get :index
      response.should be_success
      assigns(:categories).should == DrinkMenu.avail_categories
    end

    it "should be able to create a drink item" do
      post :create, drink_menu: {name: "test_item", category: "test_category"}
      response.should redirect_to drinks_path
      DrinkMenu.count.should == 1
    end

    it "should be able to edit a drink item" do
      DrinkMenu.create!(name: "test_name", category: "test_category")
      get :edit, id: DrinkMenu.last.id
      response.should be_success
      assigns(:drink_item).should == DrinkMenu.last
    end

    it "should be able to update a drink item" do
      DrinkMenu.create!(name: "test_name", category: "test_category")
      put :update, {id: DrinkMenu.last.id, drink_menu: {name: "new_name"}}
      response.should redirect_to drinks_path
      DrinkMenu.last.name.should == "new_name"
    end

    it "should be able to destroy a drink item" do
      DrinkMenu.create!(name: "test_name", category: "test_category")
      delete :destroy, id: DrinkMenu.last.id
      response.should redirect_to drinks_path
      DrinkMenu.all.empty?.should == true
    end

  end

  context "not as an authenticated user" do

    it "should redirect to sign in on index" do
      get :index
      response.should redirect_to new_user_session_path
    end

  end
end
