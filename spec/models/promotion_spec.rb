require 'rails_helper'

RSpec.describe Promotion, type: :model do
  it "has a valid factory" do
    FactoryGirl.create(:promotion).should be_valid
  end
  it "is invalid without code" do
    FactoryGirl.build(:promotion, code: nil).should_not be_valid
  end
  it "is invalid without type" do
    FactoryGirl.build(:promotion, promotion_type: nil).should_not be_valid
  end
  it "is invalid without expiration" do
    FactoryGirl.build(:promotion, expiration: nil).should_not be_valid
  end
  it "is invalid without code" do
    FactoryGirl.build(:promotion, amount: nil).should_not be_valid
  end
end
