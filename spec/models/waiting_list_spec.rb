require 'rails_helper'

RSpec.describe WaitingList, type: :model do
  it "has a valid factory" do
    FactoryGirl.create(:waiting_list).should be_valid
  end
end
