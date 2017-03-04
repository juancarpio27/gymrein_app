require 'rails_helper'

RSpec.describe Session, type: :model do
  it "has a valid factory" do
    FactoryGirl.create(:session).should be_valid
  end
  it "is invalid without platform" do
    FactoryGirl.build(:session, platform: nil).should_not be_valid
  end

  it "previously deletes previous sessions" do
    user = FactoryGirl.build(:user)
    FactoryGirl.create(:session, user: user)
    session = FactoryGirl.create(:session, user: user)
    expect(user.sessions.count).to eq 1
    expect(user.sessions.last).to eq session
  end

  it "doesn't delete the first session" do
    user = FactoryGirl.build(:user)
    session = FactoryGirl.create(:session, user: user)
    expect(user.sessions.count).to eq 1
    expect(user.sessions.last).to eq session
  end

end
