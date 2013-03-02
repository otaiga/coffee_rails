require 'spec_helper'

describe User do

  it "should be able to create a user" do
    user = User.new(email: "test_user@example.com", password: "password")
    user.save.should == true
  end

  it "should be able to update a user" do
    given_user.update_attributes(email: "new_user@example.com").should == true
    given_user.email.should == "new_user@example.com"
  end

  it "should be able to destroy a user" do
    given_user.reload
    expect {given_user.destroy}.to change(User, :count).by(-1)
  end

end
