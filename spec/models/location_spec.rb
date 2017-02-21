require 'rails_helper'

RSpec.describe Location, type: :model do
  it "has a valid factory" do
    FactoryGirl.create(:location).should be_valid
  end
end
