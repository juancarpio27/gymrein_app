require 'rails_helper'

RSpec.describe Api::V1::SessionsController, type: :controller do

  describe "login user" do
    before :each do
      @user = FactoryGirl.create(:user, password: "12345678", password_confirmation: "12345678")
    end

    it "successfully login de user" do
      post :plain, email: @user.email, password: "12345678"
      expect(response).to be_success
      json = JSON.parse(response.body)
      expect(json['email']).to eq @user.email
      expect(json['access_token']).to_not eq ""
    end

    it "returns error for wrong password" do
      post :plain, email: @user.email, password: "12345679"
      expect(response).to be_success
      json = JSON.parse(response.body)
      expect(json['success']).to eq false
    end

  end

end
