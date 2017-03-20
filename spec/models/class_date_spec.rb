require 'rails_helper'

RSpec.describe ClassDate, type: :model do

  it "has a valid factory" do
    FactoryGirl.create(:class_date).should be_valid
  end
end
