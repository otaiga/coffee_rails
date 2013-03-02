require 'spec_helper'

describe FoodsController do
  context "as an authenticated user" do
    before(:each) do
      sign_in given_user
    end

    it "should be able to access index" do
      get :index
      response.should be_success
      assigns(:categories).should == FoodMenu.avail_categories
    end

    it "should be able to create a food item" do
      post :create, food_menu: {name: "test_item", category: "test_category"}
      response.should redirect_to foods_path
      FoodMenu.count.should == 1
    end

    it "should be able to edit a food item" do
      FoodMenu.create!(name: "test_name", category: "test_category")
      get :edit, id: FoodMenu.last.id
      response.should be_success
      assigns(:food_item).should == FoodMenu.last
    end

    it "should be able to update a food item" do
      FoodMenu.create!(name: "test_name", category: "test_category")
      put :update, {id: FoodMenu.last.id, food_menu: {name: "new_name"}}
      response.should redirect_to foods_path
      FoodMenu.last.name.should == "new_name"
    end

    it "should be able to destroy a food item" do
      FoodMenu.create!(name: "test_name", category: "test_category")
      delete :destroy, id: FoodMenu.last.id
      response.should redirect_to foods_path
      FoodMenu.all.empty?.should == true
    end

  end

  context "not as an authenticated user" do

    it "should redirect to sign in on index" do
      get :index
      response.should redirect_to new_user_session_path
    end

  end

end
