require 'rails_helper'

RSpec.describe Package, type: :model do
  it "has a valid factory" do
    FactoryGirl.create(:package).should be_valid
  end
  it "is invalid without name" do
    FactoryGirl.build(:package, name: nil).should_not be_valid
  end
  it "is invalid without price" do
    FactoryGirl.build(:package, price: nil).should_not be_valid
  end
  it "is invalid without classes" do
    FactoryGirl.build(:package, classes: nil).should_not be_valid
  end
end
