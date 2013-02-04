require 'spec_helper'

describe MainsController do

  context "as an authenticated user" do
    
    before(:each) do
      sign_in given_user
    end

    describe "GET 'index'" do
      it "returns http success" do
        get 'index'
        response.should be_success
      end
    end
  end

  context "as a non-authenticated user" do

    describe "GET 'index'" do
      it "returns http success" do
        get 'index'
        response.should redirect_to new_user_session_path
      end
    end
  end

end
