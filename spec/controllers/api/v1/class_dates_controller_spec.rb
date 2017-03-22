require 'rails_helper'

RSpec.describe Api::V1::ClassDatesController, type: :controller do

  before :each do
    @api_key = FactoryGirl.create(:api_key)
    @spinning = FactoryGirl.create(:class_date, date: '01-01-2017 10:00')
    @crossfit = FactoryGirl.create(:class_date, date: '01-01-2017 14:00')
    @running = FactoryGirl.create(:class_date, date: '01-02-2017 14:00')
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(@api_key.access_token)
  end

  it "correctly shows class information" do
    get :show, id: @spinning.id
    expect(response).to be_success
    json = JSON.parse(response.body)
    expect(json['id']).to eq @spinning.id
    expect(json['location']['id']).to eq @spinning.location.id
    expect(json['instructor']['id']).to eq @spinning.instructor.id
    expect(json['event']['id']).to eq @spinning.event.id
  end

  describe "find by dates" do
    it "correctly returns two classes" do
      post :find_by_date, date: '01-01-2017'
      expect(response).to be_success
      json = JSON.parse(response.body)
      expect(json.count).to eq 2
      classes = [@spinning, @crossfit]
      classes.each_index do |i|
        expect(json[i]['event']['id']).to eq classes[i].id
      end
    end
    it "correctly returns one class" do
      post :find_by_date, date: '01-02-2017'
      expect(response).to be_success
      json = JSON.parse(response.body)
      expect(json.count).to eq 1
      classes = [@running]
      classes.each_index do |i|
        expect(json[i]['event']['id']).to eq classes[i].id
      end
    end
    it "correctly returns no class" do
      post :find_by_date, date: '01-03-2017'
      expect(response).to be_success
      json = JSON.parse(response.body)
      expect(json.count).to eq 0
    end
  end
end
