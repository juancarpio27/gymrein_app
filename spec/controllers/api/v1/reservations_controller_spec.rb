require 'rails_helper'

RSpec.describe Api::V1::ReservationsController, type: :controller do

  before :each do
    @api_key = FactoryGirl.create(:api_key)
    @spinning = FactoryGirl.create(:class_date, date: '01-01-2017 10:00')
    @crossfit = FactoryGirl.create(:class_date, date: '01-01-2017 14:00')
    @running = FactoryGirl.create(:class_date, date: '01-02-2017 14:00')

    @reservation_1 = FactoryGirl.create(:reservation, user: @api_key.user, class_date: @spinning)
    @reservation_2 = FactoryGirl.create(:reservation, user: @api_key.user, class_date: @crossfit)
    @reservation_3 = FactoryGirl.create(:reservation, user: @api_key.user, class_date: @running)

    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(@api_key.access_token)
  end

  describe "get classes by date" do
    it "get empty classes by empty date" do
      post :find_by_date, date: '01-03-2017'
      expect(response).to be_success
      json = JSON.parse(response.body)
      expect(json.count).to eq 0
    end

    it "get multiple classes for a date" do
      post :find_by_date, date: '01-01-2017'
      expect(response).to be_success
      json = JSON.parse(response.body)
      expect(json.count).to eq 2
      classes =  [@spinning, @crossfit]
      classes.each_index do |i|
        expect(json[i]['class_date_name']['name']).to eq classes[i].event.name
      end
    end

    it "get one class for a date" do
      post :find_by_date, date: '01-02-2017'
      expect(response).to be_success
      json = JSON.parse(response.body)
      expect(json.count).to eq 1
      classes =  [@running]
      classes.each_index do |i|
        expect(json[i]['class_date_name']['name']).to eq classes[i].event.name
      end
    end

  end


  describe "check in" do
    it "succesfully check in" do
      post :check_in, id: @reservation_1.id
      expect(response).to be_success
      json = JSON.parse(response.body)
      expect(json['success']).to eq true
      expect(@reservation_1.reload.assisted).to eq true
      expect(@reservation_2.reload.assisted).to eq false
      expect(@reservation_3.reload.assisted).to eq false
    end

    it "returns already checked in" do
      @reservation_1.check_in
      post :check_in, id: @reservation_1.id
      expect(response).to be_success
      json = JSON.parse(response.body)
      expect(json['success']).to eq "Already checked in"
    end
  end

  describe "create reservation" do
    it "successfully creates reservation" do
      @boxing = FactoryGirl.create(:class_date, date: '01-04-2017 14:00')
      spaces = @boxing.available
      post :create, reservation: {class_date_id: @boxing.id}
      expect(response).to be_success
      json = JSON.parse(response.body)
      expect(@boxing.reload.available).to eq spaces - 1
      expect(json['success']).to eq true
      expect(json['reservation']['class_date_id']).to eq @boxing.id
      expect(json['reservation']['user_id']).to eq @api_key.user.id
      expect(json['reservation']['assisted']).to eq false
    end

    it "returns error for overlapping class" do
      @boxing = FactoryGirl.create(:class_date, date: '01-01-2017 10:00')
      spaces = @boxing.available
      post :create, reservation: {class_date_id: @boxing.id}
      expect(response).to be_success
      json = JSON.parse(response.body)
      expect(@boxing.reload.available).to eq spaces
      expect(json['success']).to eq false
      expect(json['error']).to eq 'Already have a scheduled class'
    end

    it "returns error when class is full" do
      boxing = FactoryGirl.create(:class_date, available: 0)
      post :create, reservation: {class_date_id: boxing.id}
      expect(response).to be_success
      json = JSON.parse(response.body)
      expect(boxing.reload.available).to eq 0
      expect(json['success']).to eq false
      expect(json['error']).to eq 'Class is full'
    end

  end


end
