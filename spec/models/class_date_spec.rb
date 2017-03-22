require 'rails_helper'

RSpec.describe ClassDate, type: :model do

  it "has a valid factory" do
    FactoryGirl.create(:class_date).should be_valid
  end

  it "successfully calculates finish time" do
    class_date = FactoryGirl.create(:class_date, duration: 120, date: '01-01-2017 11:00')
    expect(class_date.finish).to eq '01-01-2017 13:00'
  end

end
