require 'rails_helper'

RSpec.describe Instructor, type: :model do
  it "has a valid factory" do
    FactoryGirl.create(:instructor).should be_valid
  end

  it "is invalid without name" do
    FactoryGirl.build(:instructor, name: nil).should_not be_valid
  end

  it "is invalid without lastname" do
    FactoryGirl.build(:instructor, lastname: nil).should_not be_valid
  end

  it "returns correct full name" do
    i = FactoryGirl.create(:instructor, name: "John", lastname: "Doe")
    expect(i.full_name).to eq "John Doe"
  end

end
