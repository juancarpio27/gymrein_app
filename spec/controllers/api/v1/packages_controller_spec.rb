require 'rails_helper'

RSpec.describe Api::V1::PackagesController, type: :controller do


  before :each do
    @api_key = FactoryGirl.create(:api_key)
    @premium = FactoryGirl.create(:package)
    @basic = FactoryGirl.create(:package)
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(@api_key.access_token)
  end

  it "successfully returns list of cards" do
    get :index
    expect(response).to be_success
    json = JSON.parse(response.body)
    i = 0
    packages_array = [@premium, @basic]
    packages_array.each do |package|
      expect(json[i]['name']).to eq package.name
      expect(json[i]['price']).to eq package.price
      expect(json[i]['classes']).to eq package.classes
      i += 1
    end
  end

  it "successfully return a package" do
    get :show, id: @premium.id
    expect(response).to be_success
    json = JSON.parse(response.body)
    expect(json['name']).to eq @premium.name
    expect(json['price']).to eq @premium.price
    expect(json['classes']).to eq @premium.classes

  end


end
