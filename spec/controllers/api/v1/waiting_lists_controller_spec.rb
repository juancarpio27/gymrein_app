require 'rails_helper'

RSpec.describe Api::V1::WaitingListsController, type: :controller do

  describe "add to waiting list" do
    before :each do
      @api_key = FactoryGirl.create(:api_key)
      @spinning = FactoryGirl.create(:class_date,  date: '01-04-2017 14:00', duration: 60)
      request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(@api_key.access_token)
    end

    it "successfully creates the class" do
      post :create, waiting_list: {class_date_id: @spinning.id}
      expect(response).to be_success
      json = JSON.parse(response.body)
      expect(json['waiting_list']['class_date_id']).to eq @spinning.id
      expect(json['success']).to eq true
    end

    it "returns error with overlapping class" do
      @boxing = FactoryGirl.create(:class_date,  date: '01-04-2017 13:30',duration: 60)
      reservation = FactoryGirl.create(:reservation, class_date: @boxing, user: @api_key.user)
      post :create, waiting_list: {class_date_id: @spinning.id}
      expect(response).to be_success
      json = JSON.parse(response.body)
      expect(json['success']).to eq false
    end
  end

  describe "index, show and destroy" do
    before :each do
      @api_key = FactoryGirl.create(:api_key)
      @spinning = FactoryGirl.create(:class_date)
      @boxing = FactoryGirl.create(:class_date)

      @waiting_spinning = FactoryGirl.create(:waiting_list, user: @api_key.user, class_date: @spinning)
      @waiting_boxing = FactoryGirl.create(:waiting_list, user: @api_key.user, class_date: @boxing)

      request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(@api_key.access_token)
    end

    it "index all waiting list" do
      get :index
      expect(response).to be_success
      json = JSON.parse(response.body)
      classes = [@waiting_spinning, @waiting_boxing]
      classes.each_index do |i|
        expect(json[i]['id']).to eq classes[i].id
      end

    end
    it "show waiting list details" do
      get :show, id: @waiting_spinning.id
      expect(response).to be_success
      json = JSON.parse(response.body)
      expect(json['id']).to eq @waiting_spinning.id

    end
    it "destroy waiting lists" do
      expect(@api_key.user.waiting_lists.count).to eq 2
      delete :destroy, id: @waiting_spinning.id
      expect(response).to be_success
      json = JSON.parse(response.body)
      expect(@api_key.user.reload.waiting_lists.count).to eq 1
    end
  end

end
