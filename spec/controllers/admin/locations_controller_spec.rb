require 'rails_helper'

RSpec.describe Admin::LocationsController, type: :controller do

  before :each do
    @admin = FactoryGirl.create(:admin)
    session[:admin_id] = @admin.id
  end

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #edit" do

    before :each do
      @location = FactoryGirl.create(:location)
    end

    it "returns http success" do
      get :edit, id: @location
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do

    before :each do
      @location = FactoryGirl.create(:location)
    end

    it "returns http success" do
      get :show, id: @location
      expect(response).to have_http_status(:success)
    end
  end

end
