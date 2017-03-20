require 'rails_helper'

RSpec.describe Api::V1::ReservationsController, type: :controller do

  before :each do
    @api_key = FactoryGirl.create(:api_key)
    @spinning = FactoryGirl.create(:class_date, date: '01-01-2017 10:00')
    @crossfit = FactoryGirl.create(:class_date, date: '01-01-2017 14:00')
    @running = FactoryGirl.create(:class_date, date: '01-02-2017 14:00')

    @reservation_1 = FactoryGirl.create(:reservation, user: @api_key.user, class_date: @spinning)
    @reservation_2 = FactoryGirl.create(:reservation, user: @api_key.user, class_date: @crossfit)
    @reservation_3 = FactoryGirl.create(:reservation, user: @api_key.user, class_date: @running)

    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(@api_key.access_token)
  end

  describe "get classes by date" do
    it "get empty classes by empty date" do
      post :find_by_date, date: '01-03-2017'
      expect(response).to be_success
      json = JSON.parse(response.body)
      expect(json.count).to eq 0
    end

    it "get multiple classes for a date" do
      post :find_by_date, date: '01-01-2017'
      expect(response).to be_success
      json = JSON.parse(response.body)
      expect(json.count).to eq 2
      classes =  [@spinning, @crossfit]
      classes.each_index do |i|
        expect(json[i]['class_date_name']['name']).to eq classes[i].event.name
      end
    end

    it "get one class for a date" do
      post :find_by_date, date: '01-02-2017'
      expect(response).to be_success
      json = JSON.parse(response.body)
      expect(json.count).to eq 1
      classes =  [@running]
      classes.each_index do |i|
        expect(json[i]['class_date_name']['name']).to eq classes[i].event.name
      end
    end

  end

end
