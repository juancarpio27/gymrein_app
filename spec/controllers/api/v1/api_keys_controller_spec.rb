require 'rails_helper'

RSpec.describe Api::V1::ApiKeysController, type: :controller do

  describe "valid api key" do
    before :each do
      @api_key = FactoryGirl.create(:api_key)
      request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(@api_key.access_token)
    end

    it "successfully validates an existing token" do
      post :validate
      expect(response).to be_success
      json = JSON.parse(response.body)
      expect(json['validate']).to eq true
    end
  end

  describe "invalid api key" do
    before :each do
      request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials("InvalidToken")
    end

    it "successfully returns unauthorized" do
      post :validate
      response.response_code.should == 401
    end
  end



end
