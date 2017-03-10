require 'rails_helper'

RSpec.describe Api::V1::InstructorsController, type: :controller do


  before :each do
    @api_key = FactoryGirl.create(:api_key)
    @instructor = FactoryGirl.create(:instructor)
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(@api_key.access_token)
  end

  it "shows correct instructor" do
    get :show, id: @instructor.id
    expect(response).to be_success
    json = JSON.parse(response.body)
    expect(json['name']).to eq @instructor.name
    expect(json['lastname']).to eq @instructor.lastname
    expect(json['biography']).to eq @instructor.biography
  end


end
