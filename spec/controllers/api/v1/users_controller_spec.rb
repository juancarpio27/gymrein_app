require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do

  describe "create user" do
    it "sucessfully create an user" do
      post :create, user: {name: "Bob", lastname: "Johson", email: "bob@email.com",
                           password: "12345678", password_confirmation: "12345678", phone: "5512341234"}

      # test for the 200 status-code
      expect(response).to be_success
      json = JSON.parse(response.body)
      expect(json['name']).to eq "Bob"
      expect(json['lastname']).to eq "Johson"
      expect(json['email']).to eq "bob@email.com"

    end

    it "response with error when name is empty" do
      post :create, user: {lastname: "Johson", email: "bob@email.com",
                           password: "12345678", password_confirmation: "12345678", phone: "5512341234"}
      expect(response.status).to eq 422
    end

    it "response with error when lastname is empty" do
      post :create, user: {name: "Bob", email: "bob@email.com",
                           password: "12345678", password_confirmation: "12345678", phone: "5512341234"}
      expect(response.status).to eq 422
    end

    it "response with error when email is empty" do
      post :create, user: {name: "Bob", lastname: "Johson",
                           password: "12345678", password_confirmation: "12345678", phone: "5512341234"}
      expect(response.status).to eq 422
    end

    it "response with error when passwords are different" do
      post :create, user: {name: "Bob", lastname: "Johson",
                           password: "12345679", password_confirmation: "12345678", phone: "5512341234"}
      expect(response.status).to eq 422
    end

    it "response with error when phone is empty" do

      post :create, user: {name: "Bob", lastname: "Johson", email: "bob@email.com",
                           password: "12345678", password_confirmation: "12345678"}
      expect(response.status).to eq 422

    end
  end

  describe "Update user" do
    before :each do
      @api_key = FactoryGirl.create(:api_key)
      request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(@api_key.access_token)
    end

    it "correctly updates the name" do
      patch :update, user: {name: "Bob"}
      expect(response).to be_success
      json = JSON.parse(response.body)
      expect(json['name']).to eq "Bob"
    end

    it "correctly updates the lastname" do
      patch :update, user: {lastname: "Nunez"}
      expect(response).to be_success
      json = JSON.parse(response.body)
      expect(json['lastname']).to eq "Nunez"
    end

    it "correctly updates the phone" do
      patch :update, user: {phone: "12341234"}
      expect(response).to be_success
      json = JSON.parse(response.body)
      expect(json['phone']).to eq "12341234"
    end

    it "correctly updates the password" do
      patch :update, user: {password: "12341234", password_confirmation: "12341234"}
      expect(response).to be_success
      @api_key.user.valid_password?("12341234")
    end

    it "doesnt allow to save with empty name" do
      patch :update, user: {name: ""}
      expect(response.status).to eq 422
    end

    it "doesnt allow to save with empty lastname" do
      patch :update, user: {lastname: ""}
      expect(response.status).to eq 422
    end

    it "doesnt allow to save with empty phone" do
      patch :update, user: {phone: ""}
      expect(response.status).to eq 422
    end

    it "doesnt allow to save with not matching passwords" do
      patch :update, user: {password: "12341234", password_confirmation: "12341235"}
      expect(response.status).to eq 422
    end


  end


end
