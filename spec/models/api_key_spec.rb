require 'rails_helper'

RSpec.describe ApiKey, type: :model do
  it "has a valid factory" do
    FactoryGirl.create(:api_key).should be_valid
  end
  it  "creates access token" do
     a = FactoryGirl.build(:api_key)
     expect(a.access_token).not_to eq ""
  end
end
