require 'spec_helper'

describe HoursController do
  context "as an authenticated user" do
    before(:each) do
      sign_in given_user
    end

    before(:all) do
      @test_data = {
        weekday: "Monday",
        open_time: "09:00",
        close_time: "14:00"
      }
    end

    it "should be able to access index" do
      get :index
      response.should be_success
      assigns(:opening_times).should == OpeningTime.all
    end

    it "should be able to create a opening time" do
      post :create, opening_time: @test_data
      response.should redirect_to hours_path
      OpeningTime.count.should == 1
    end

    it "should be able to edit a opening time" do
      OpeningTime.create!(@test_data)
      get :edit, id: OpeningTime.last.id
      response.should be_success
      assigns(:opening_time).should == OpeningTime.last
    end

    it "should be able to update a opening time" do
      OpeningTime.create!(@test_data)
      put :update, {id: OpeningTime.last.id, opening_time: {weekday: "new_day"}}
      response.should redirect_to hours_path
      OpeningTime.last.weekday.should == "new_day"
    end

    it "should be able to destroy a opening time" do
      OpeningTime.create!(@test_data)
      delete :destroy, id: OpeningTime.last.id
      response.should redirect_to hours_path
      OpeningTime.all.empty?.should == true
    end

    it "should not be able to create same weekday entries" do
      OpeningTime.create!(@test_data)
      same = OpeningTime.new(@test_data)
      same.save.should == false
    end

    it "should display remaing days to create and edit" do
      OpeningTime.create!(@test_data)
      get :new
      date_array = assigns(:days)
      date_array.include?("Monday").should == false
    end

  end

  context "not as an authenticated user" do

    it "should redirect to sign in on index" do
      get :index
      response.should redirect_to new_user_session_path
    end

  end

end
