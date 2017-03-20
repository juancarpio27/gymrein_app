require 'rails_helper'

RSpec.describe Api::V1::ClassDatesController, type: :controller do

  before :each do
    @api_key = FactoryGirl.create(:api_key)
    @spinning = FactoryGirl.create(:class_date, date: '01-01-2017 10:00')
    @crossfit = FactoryGirl.create(:class_date, date: '01-01-2017 14:00')
    @running = FactoryGirl.create(:class_date, date: '01-02-2017 14:00')
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(@api_key.access_token)
  end



end
