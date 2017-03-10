require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do

  describe "create user" do

    describe "user creation" do

      before :each do
        post :create, user: {name: "Bob", lastname: "Johson", email: "bob@email.com",
                             password: "12345678", password_confirmation: "12345678", phone: "5512341234",
                             sex: "male", birth: "01-01-2016"}, platform: "android"
        @response = response
      end

      it "sucessfully create an user" do


        # test for the 200 status-code
        expect(@response).to be_success
        json = JSON.parse(@response.body)
        expect(json['name']).to eq "Bob"
        expect(json['lastname']).to eq "Johson"
        expect(json['email']).to eq "bob@email.com"
        expect(json['sex']).to eq "male"

      end
      it "sucessfully logs an user when created" do
        expect(@response).to be_success
        json = JSON.parse(@response.body)
        expect(json['access_token']).to_not eq nil
      end
    end

    describe "params validations" do
      it "response with error when name is empty" do
        post :create, user: {lastname: "Johson", email: "bob@email.com",
                             password: "12345678", password_confirmation: "12345678", phone: "5512341234",
                             sex: "male", birth: "01-01-2016"}
        expect(response.status).to eq 422
      end

      it "response with error when lastname is empty" do
        post :create, user: {name: "Bob", email: "bob@email.com",
                             password: "12345678", password_confirmation: "12345678", phone: "5512341234",
                             sex: "male", birth: "01-01-2016"}
        expect(response.status).to eq 422
      end

      it "response with error when email is empty" do
        post :create, user: {name: "Bob", lastname: "Johson",
                             password: "12345678", password_confirmation: "12345678", phone: "5512341234",
                             sex: "male", birth: "01-01-2016"}
        expect(response.status).to eq 422
      end

      it "response with error when passwords are different" do
        post :create, user: {name: "Bob", lastname: "Johson",
                             password: "12345679", password_confirmation: "12345678", phone: "5512341234",
                             sex: "male", birth: "01-01-2016"}
        expect(response.status).to eq 422
      end

      it "response with error when phone is empty" do

        post :create, user: {name: "Bob", lastname: "Johson", email: "bob@email.com",
                             password: "12345678", password_confirmation: "12345678",
                             sex: "male", birth: "01-01-2016"}
        expect(response.status).to eq 422

      end

      it "response with error when sex is empty" do

        post :create, user: {name: "Bob", lastname: "Johson", email: "bob@email.com",
                             password: "12345678", password_confirmation: "12345678",
                             phone: "12341234", birth: "01-01-2016"}
        expect(response.status).to eq 422

      end

      it "response with error when birth is empty" do

        post :create, user: {name: "Bob", lastname: "Johson", email: "bob@email.com",
                             password: "12345678", password_confirmation: "12345678",
                             phone: "12341234", sex: "male"}
        expect(response.status).to eq 422

      end
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

    it "correctly updates the birth" do
      patch :update, user: {birth: "10-10-1990"}
      expect(response).to be_success
      json = JSON.parse(response.body)
      expect(json['birth']).to eq "1990-10-10"
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

  describe "email validation" do

    before :each do
      @user = FactoryGirl.create(:user)
    end

    it "returns true for existing email" do
      post :validate, email: @user.email
      expect(response.status).to eq 200
      json = JSON.parse(response.body)
      expect(json['exists']).to eq true
    end

    it "returns false for existing email" do
      post :validate, email: "non-existing@non.com"
      expect(response.status).to eq 200
      json = JSON.parse(response.body)
      expect(json['exists']).to eq false
    end

  end


end
