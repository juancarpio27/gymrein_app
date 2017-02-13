require 'rails_helper'

RSpec.describe Session, type: :model do
  it "has a valid factory" do
    FactoryGirl.create(:session).should be_valid
  end
  it "is invalid without platform" do
    FactoryGirl.build(:session, platform: nil).should_not be_valid
  end
end
