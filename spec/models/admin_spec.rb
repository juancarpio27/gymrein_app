require 'rails_helper'

RSpec.describe Admin, type: :model do
  it "has a valid factory" do
    FactoryGirl.create(:admin).should be_valid
  end

  it "is invalid without username" do
    FactoryGirl.build(:admin, username: nil).should_not be_valid
  end

  it "is invalid with different passwords" do
    FactoryGirl.build(:admin,password: "12345678", password_confirmation: "12345679").should_not be_valid
  end

  describe "validation" do

    before :each do
      @admin = FactoryGirl.create(:admin,password: "12345678", password_confirmation: "12345678")
    end

    it "correctly validates an admin" do
      result = Admin.authenticate(@admin.username,"12345678")
      expect(result).to eq @admin
    end
    it "correctly denies access to an admin" do
      result = Admin.authenticate(@admin.username,"12345679")
      expect(result).to eq nil
    end

  end
end
