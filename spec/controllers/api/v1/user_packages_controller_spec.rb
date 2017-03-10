require 'rails_helper'

RSpec.describe Api::V1::UserPackagesController, type: :controller do

  before :each do
    @api_key = FactoryGirl.create(:api_key)
    @card = FactoryGirl.create(:card)
    @package = FactoryGirl.create(:package, price: 400)
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
  end


end
