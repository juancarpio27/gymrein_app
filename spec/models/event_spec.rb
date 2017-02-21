require 'rails_helper'

RSpec.describe Event, type: :model do
  it "has a valid factory" do
    FactoryGirl.create(:event).should be_valid
  end
end
