require 'rails_helper'

RSpec.describe Admin::MenuController, type: :controller do

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

end
