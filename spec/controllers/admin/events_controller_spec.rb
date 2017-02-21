require 'rails_helper'

RSpec.describe Admin::EventsController, type: :controller do

  before :each do
    @admin = FactoryGirl.create(:admin)
    session[:admin_id] = @admin.id
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #index" do
    it "redirect to event index" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #edit" do

    before :each do
      @event = FactoryGirl.create(:event)
    end

    it "redirect to event" do
      get :edit, id: @event.id
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do

    before :each do
      @event = FactoryGirl.create(:event)
    end

    it "returns http success" do
      get :show, id: @event.id
      expect(response).to have_http_status(:success)
    end
  end

end
