require "test_helper"

class UserTest < ActiveSupport::TestCase
  @@weak_pass_message = "Password Password should have more than 8 characters including 1 uppercase letter, 1 number, 1 special character"

  test "should have strong password" do
    user = User.new \
      email: "gra@example.com",
      role: "admin",
      password: "Test1234!",
      password_confirmation: "Test1234!"

    assert user.valid?
  end

  test "should not have weak password" do
    user = User.new \
      email: "gra@example.com",
      role: "admin",
      password: "123456",
      password_confirmation: "123456"


    assert_not user.valid?
    assert [@@weak_pass_message] == user.errors.full_messages
  end
end
