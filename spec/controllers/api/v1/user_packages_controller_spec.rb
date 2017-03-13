require 'rails_helper'

RSpec.describe Api::V1::UserPackagesController, type: :controller do

  describe "buy packages" do
    before :each do
      @api_key = FactoryGirl.create(:api_key)
      @card = FactoryGirl.create(:card)
      @package = FactoryGirl.create(:package, price: 400, classes: 10)
      request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(@api_key.access_token)
    end

    it "correctly saves user package with no promotion" do
      post :create, card_id: @card.id, package_id: @package.id, promotion_id: nil
      expect(response).to be_success
      json = JSON.parse(response.body)
      expect(json['card_id']).to eq @card.id
      expect(json['package_id']).to eq @package.id
      expect(json['user_id']).to eq @api_key.user.id
      expect(json['promotion_id']).to eq nil
      expect(json['price']).to eq 400
      expect(json['user']['available_classes']).to eq 10
      expect(@api_key.user.reload.available_classes).to eq 10
    end

    it "correctly saves user package with quantity promotion" do
      promotion = FactoryGirl.create(:promotion, promotion_type: "quantity", amount: 80)
      post :create, card_id: @card.id, package_id: @package.id, promotion_id: promotion.id
      expect(response).to be_success
      json = JSON.parse(response.body)
      expect(json['card_id']).to eq @card.id
      expect(json['package_id']).to eq @package.id
      expect(json['user_id']).to eq @api_key.user.id
      expect(json['promotion_id']).to eq promotion.id
      expect(json['price']).to eq 320
      expect(json['user']['available_classes']).to eq 10
      expect(@api_key.user.reload.available_classes).to eq 10
    end

    it "correctly saves user package with quantity promotion" do
      promotion = FactoryGirl.create(:promotion, promotion_type: "percentage", amount: 30)
      post :create, card_id: @card.id, package_id: @package.id, promotion_id: promotion.id
      expect(response).to be_success
      json = JSON.parse(response.body)
      expect(json['card_id']).to eq @card.id
      expect(json['package_id']).to eq @package.id
      expect(json['user_id']).to eq @api_key.user.id
      expect(json['promotion_id']).to eq promotion.id
      expect(json['price']).to eq 280
      expect(json['user']['available_classes']).to eq 10
      expect(@api_key.user.reload.available_classes).to eq 10
    end
  end

  describe "index bought payments" do
    before :each do
      @api_key = FactoryGirl.create(:api_key)
      request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(@api_key.access_token)
    end

    it "returns empty array for no packages" do
      get :index
      expect(response).to be_success
      json = JSON.parse(response.body)
      expect(json.count).to eq 0
    end

    it "returns empty array for no packages" do
      package_1 = FactoryGirl.create(:user_package, user: @api_key.user)
      package_2 = FactoryGirl.create(:user_package, user: @api_key.user)
      get :index
      expect(response).to be_success
      json = JSON.parse(response.body)
      result = [package_1, package_2]
      result.each_index do |i|
        expect(json[i]['package_id']).to eq result[i].id
      end
    end

  end
end
