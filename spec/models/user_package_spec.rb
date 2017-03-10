require 'rails_helper'

RSpec.describe UserPackage, type: :model do
  it "has a valid factory" do
    FactoryGirl.create(:user_package).should be_valid
  end

  describe "price calculations" do

    before :each do
      @package = FactoryGirl.create(:package, price: 200)
    end

    it "returns correct price with no promotion" do
      user_package = FactoryGirl.create(:user_package, promotion: nil, package: @package)
      expect(user_package.calculate_price).to eq 200
    end

    it "returns correct price with quantity promotion" do
      promotion = FactoryGirl.create(:promotion, promotion_type: "quantity", amount: 10)
      user_package = FactoryGirl.create(:user_package, promotion: promotion, package: @package)
      expect(user_package.calculate_price).to eq 190
    end

    it "returns correct price with percentage promotion" do
      promotion = FactoryGirl.create(:promotion, promotion_type: "percentage", amount: 10)
      user_package = FactoryGirl.create(:user_package, promotion: promotion, package: @package)
      expect(user_package.calculate_price).to eq 180
    end

  end
end
