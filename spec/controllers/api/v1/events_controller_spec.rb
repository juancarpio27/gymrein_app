require 'rails_helper'

RSpec.describe Api::V1::EventsController, type: :controller do

  before :each do
    @api_key = FactoryGirl.create(:api_key)
    @event = FactoryGirl.create(:event)
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(@api_key.access_token)
  end

  it "shows correct event" do
    get :show, id: @event.id
    expect(response).to be_success
    json = JSON.parse(response.body)
    expect(json['name']).to eq @event.name
    expect(json['description']).to eq @event.description
  end

end
