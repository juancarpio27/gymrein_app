require 'rails_helper'

RSpec.describe Api::V1::PromotionsController, type: :controller do

  before :each do
    @api_key = FactoryGirl.create(:api_key)
    @promotion = FactoryGirl.create(:promotion)
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(@api_key.access_token)
  end

  it "succesfully return existing promotion" do
    post :validate, code: @promotion.code
    expect(response).to be_success
    json = JSON.parse(response.body)
    expect(json['code']).to eq @promotion.code
    expect(json['promotion_type']).to eq @promotion.promotion_type
    expect(json['amount']).to eq @promotion.amount

  end
  it "returns error for an unexistant promotion" do
    post :validate, code: "incorrect"
    expect(response).to be_success
    json = JSON.parse(response.body)
    expect(json['errors']).to eq "Promotion not found."
  end


end
