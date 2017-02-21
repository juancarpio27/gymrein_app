require 'rails_helper'

RSpec.describe Admin::InstructorsController, type: :controller do

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
      @instructor = FactoryGirl.create(:instructor)
    end

    it "returns http success" do
      get :edit, id: @instructor.id
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do

    before :each do
      @instructor = FactoryGirl.create(:instructor)
    end

    it "returns http success" do
      get :show, id: @instructor.id
      expect(response).to have_http_status(:success)
    end
  end

end
