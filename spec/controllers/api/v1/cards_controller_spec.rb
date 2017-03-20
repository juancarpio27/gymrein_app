require 'rails_helper'

RSpec.describe Api::V1::CardsController, type: :controller do

  describe "index cards" do

    before :each do
      @api_key = FactoryGirl.create(:api_key)
      @card = FactoryGirl.create(:card, user: @api_key.user)
      request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(@api_key.access_token)
    end

    it "successfully returns list of cards" do
      get :index
      expect(response).to be_success
      json = JSON.parse(response.body)
      i = 0
      card_array = [@card]
      card_array.each do |card|
        expect(json[i]['brand']).to eq card.brand
        expect(json[i]['holder_name']).to eq card.holder_name
        expect(json[i]['number']).to eq card.number
        expect(json[i]['expiration_month']).to eq card.expiration_month
        expect(json[i]['expiration_year']).to eq card.expiration_year
        i += 1
      end
    end
  end

  describe "create card" do

    before :each do
      @api_key = FactoryGirl.create(:api_key)
      request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(@api_key.access_token)
    end

    it "successfully creates a card" do
      post :create, card: {number: "1234123412341234", holder_name: "testing", expiration_month: 12,
                           expiration_year: 18, brand: "mc", cvv: 123  }
      expect(response).to be_success
      json = JSON.parse(response.body)
      expect(json['number']).to eq "1234"
      expect(json['holder_name']).to eq "testing"
      expect(json['expiration_month']).to eq 12
      expect(json['expiration_year']).to eq 18
      expect(json['brand']).to eq "mc"
    end

    it "returns error with empty number" do
      post :create, card: {holder_name: "testing", expiration_month: 12,
                           expiration_year: 18, brand: "mc"  }
      expect(response.status).to eq 422
    end
    it "returns error with empty holder_name" do
      post :create, card: {number: "1234123412341234", expiration_month: 12,
                           expiration_year: 18, brand: "mc"  }
      expect(response.status).to eq 422
    end
    it "returns error with empty expiration_month" do
      post :create, card: {number: "1234123412341234", holder_name: "testing",
                           expiration_year: 18, brand: "mc"  }
      expect(response.status).to eq 422
    end
    it "returns error with empty expiration_year" do
      post :create, card: {number: "1234123412341234", holder_name: "testing", expiration_month: 12,
                           brand: "mc"  }
      expect(response.status).to eq 422
    end
    it "returns error with empty brand" do
      post :create, card: {number: "1234123412341234", holder_name: "testing", expiration_month: 12,
                           expiration_year: 18 }
      expect(response.status).to eq 422
    end
  end

  describe "delete card" do
    before :each do
      @api_key = FactoryGirl.create(:api_key)
      @card = FactoryGirl.create(:card, user: @api_key.user)
      request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(@api_key.access_token)
    end

    it "successfully destroy the card" do
      delete :destroy, id: @card.id
      expect(@api_key.user.cards.count).to eq 0
    end
  end



end
