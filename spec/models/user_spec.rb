require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) do
    @user = User.create(name: 'Example',
                      password: 'password', password_confirmation: 'password')
  end

  it "should be valid" do
    expect(@user).to be_valid
  end

  context "name" do
    it "should not be blank" do
      @user.name = ""
      expect(@user).to be_invalid
    end

    it "should be 32 characters or less" do
      @user.name = "12345678901234567890123456789012"
      expect(@user).to be_valid
      @user.name = "123456789012345678901234567890123"
      expect(@user).to be_invalid
    end

    it "should not allow two users with the same name" do
      user_count = User.count
      user2 = User.create(name: 'Example',
      password: 'password', password_confirmation: 'password')

      expect(User.count).to eq(user_count)
      expect(user2.errors.full_messages).to include("Name has already been taken")

    end
  end

  context "password" do
    it "should not be blank" do
      @user.update_attributes(password: "", password_confirmation: "")
      expect(@user).to be_invalid
    end

    it "should be at least six characters" do
      @user.update_attributes(password: "test", password_confirmation: "test")
      expect(@user).to be_invalid
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end
  end

end
