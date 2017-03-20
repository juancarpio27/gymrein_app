require 'rails_helper'

RSpec.describe Reservation, type: :model do
  it "has a valid factory" do
    FactoryGirl.create(:reservation).should be_valid
  end
end
