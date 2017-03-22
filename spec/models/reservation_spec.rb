require 'rails_helper'

RSpec.describe Reservation, type: :model do
  it "has a valid factory" do
    FactoryGirl.create(:reservation).should be_valid
  end

  it "puts false as default in assisted" do
    reservation = FactoryGirl.create(:reservation)
    expect(reservation.assisted).to eq false
  end

  it "succesfully checks in" do
    reservation = FactoryGirl.create(:reservation)
    reservation.check_in
    expect(reservation.assisted).to eq true
  end


end
