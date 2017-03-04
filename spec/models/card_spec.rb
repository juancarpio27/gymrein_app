require 'rails_helper'

RSpec.describe Card, type: :model do
  it "has a valid factory" do
    FactoryGirl.create(:card).should be_valid
  end
  it "is invalid without user" do
    FactoryGirl.build(:card, user: nil).should_not be_valid
  end
  it "is invalid without holder_name" do
    FactoryGirl.build(:card, holder_name: nil).should_not be_valid
  end
  it "is invalid without number" do
    FactoryGirl.build(:card, number: nil).should_not be_valid
  end
  it "is invalid without expiration_month" do
    FactoryGirl.build(:card, expiration_month: nil).should_not be_valid
  end
  it "is invalid without expiration_year" do
    FactoryGirl.build(:card, expiration_year: nil).should_not be_valid
  end
  it "is invalid without brand" do
    FactoryGirl.build(:card, brand: nil).should_not be_valid
  end

  it "correctly sanitize card number" do
    card = FactoryGirl.create(:card, number: "1234123412341234")
    expect(card.number).to eq "1234"
  end

end
