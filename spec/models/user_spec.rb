require 'rails_helper'

RSpec.describe User, type: :model do
  it "has a valid factory" do
    FactoryGirl.create(:user).should be_valid
  end
  it "is invalid without email" do
    FactoryGirl.build(:user, email: nil).should_not be_valid
  end
  it "is invalid without name" do
    FactoryGirl.build(:user, name: nil).should_not be_valid
  end
  it "is invalid without lastname" do
    FactoryGirl.build(:user, lastname: nil).should_not be_valid
  end
  it "is invalid without phone" do
    FactoryGirl.build(:user, phone: nil).should_not be_valid
  end
  it "doesn't allow repeated email" do
    user = FactoryGirl.create(:user)
    FactoryGirl.build(:user, email: user.email).should_not be_valid
  end
  it "has secure password" do
    FactoryGirl.build(:user, password: "12345678", password_confirmation: "12345679").should_not be_valid
  end
end
