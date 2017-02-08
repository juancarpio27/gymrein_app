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
end
