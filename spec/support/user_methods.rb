def given_user
  @user ||= User.create!(email: "test_user@example.com", password: "password")
end