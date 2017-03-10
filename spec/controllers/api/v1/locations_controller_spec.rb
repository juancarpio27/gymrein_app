require 'rails_helper'

RSpec.describe Api::V1::LocationsController, type: :controller do

  before :each do
    @api_key = FactoryGirl.create(:api_key)
    @location = FactoryGirl.create(:location)
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(@api_key.access_token)
  end

  it "shows correct location" do
    get :show, id: @location.id
    expect(response).to be_success
    json = JSON.parse(response.body)
    expect(json['name']).to eq @location.name
    expect(json['address']).to eq @location.address
  end

end
