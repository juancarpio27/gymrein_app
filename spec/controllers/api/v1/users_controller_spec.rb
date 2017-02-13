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


end
