require 'rails_helper'

RSpec.describe Api::V1::ReservationsController, type: :controller do

  before :each do
    @user = FactoryGirl.create(:user, available_classes: 10)
    @api_key = FactoryGirl.create(:api_key, user: @user)
    @spinning = FactoryGirl.create(:class_date, date: '01-01-2017 10:00')
    @crossfit = FactoryGirl.create(:class_date, date: '01-01-2017 14:00')
    @running = FactoryGirl.create(:class_date, date: '01-02-2017 14:00')
    @future = FactoryGirl.create(:class_date,date: Time.now.in_time_zone('Mexico City') + 6.hours)

    @reservation_1 = FactoryGirl.create(:reservation, user: @api_key.user, class_date: @spinning)
    @reservation_2 = FactoryGirl.create(:reservation, user: @api_key.user, class_date: @crossfit)
    @reservation_3 = FactoryGirl.create(:reservation, user: @api_key.user, class_date: @running)
    @reservation_4 = FactoryGirl.create(:reservation, user: @api_key.user, class_date: @future)

    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(@api_key.access_token)
  end

  describe "get classes by date" do


    it "get future classes" do
      get :future
      expect(response).to be_success
      json = JSON.parse(response.body)
      expect(json.count).to eq 1
      expect(json[0]['id']).to eq @reservation_4.id
    end


    it "get empty classes by empty date" do
      post :find_by_date, date: '2017-03-01 10:00:00 +0000'
      expect(response).to be_success
      json = JSON.parse(response.body)
      expect(json.count).to eq 0
    end

    it "get multiple classes for a date" do
      post :find_by_date, date: '2017-01-01 10:00:00 +0000'
      expect(response).to be_success
      json = JSON.parse(response.body)
      expect(json.count).to eq 2
      classes =  [@spinning, @crossfit]
      classes.each_index do |i|
        expect(json[i]['class_date']['event_id']).to eq classes[i].event.id
      end
    end

    it "get one class for a date" do
      post :find_by_date, date: '2017-02-01 10:00:00 +0000'
      expect(response).to be_success
      json = JSON.parse(response.body)
      expect(json.count).to eq 1
      classes =  [@running]
      classes.each_index do |i|
        expect(json[i]['class_date']['event_id']).to eq classes[i].event.id
      end
    end

  end


  describe "create reservation" do
    it "successfully creates reservation" do
      classes = @api_key.user.available_classes
      @boxing = FactoryGirl.create(:class_date, date: '01-04-2017 14:00', limit: 40)
      post :create, reservation: {class_date_id: @boxing.id}
      expect(response).to be_success
      json = JSON.parse(response.body)
      expect(json['success']).to eq true
      expect(@boxing.reload.available).to eq 39
      expect(json['reservation']['class_date_id']).to eq @boxing.id
      expect(json['reservation']['user_id']).to eq @api_key.user.id
      expect(json['reservation']['assisted']).to eq false
      expect(@api_key.user.reload.available_classes).to eq classes - 1
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
      boxing = FactoryGirl.create(:class_date, limit: 0)
      post :create, reservation: {class_date_id: boxing.id}
      expect(response).to be_success
      json = JSON.parse(response.body)
      expect(boxing.reload.available).to eq 0
      expect(json['success']).to eq false
      expect(json['error']).to eq 'Class is full'
    end

    it "returns error when user has no classes" do
      @user.available_classes = 0
      @user.save!
      boxing = FactoryGirl.create(:class_date)
      post :create, reservation: {class_date_id: boxing.id}
      expect(response).to be_success
      json = JSON.parse(response.body)
      expect(json['success']).to eq false
      expect(json['error']).to eq 'No available classes'
    end

  end

  describe "destroy reservation" do

    it "dont allow to cancel less than 90 minutes before class" do
      boxing = FactoryGirl.create(:class_date, date: Time.now - 5.hours + 50.minutes)
      reservation = FactoryGirl.create(:reservation, user: @api_key.user, class_date: boxing)
      delete :destroy, id: reservation.id
      expect(response).to be_success
      json = JSON.parse(response.body)
      expect(json['success']).to eq false
      expect(json['error']).to eq 'Can not cancel 90 minutes before class'
    end

    it "dont allow to cancel past classes" do
      boxing = FactoryGirl.create(:class_date, date: '01-01-2001')
      reservation = FactoryGirl.create(:reservation, user: @api_key.user, class_date: boxing)
      delete :destroy, id: reservation.id
      expect(response).to be_success
      json = JSON.parse(response.body)
      expect(json['success']).to eq false
      expect(json['error']).to eq 'Class is already done'
    end

    it "cancels class with no waiting list" do
      boxing = FactoryGirl.create(:class_date, date: '01-01-2018', limit: 40)
      reservation = FactoryGirl.create(:reservation, user: @api_key.user, class_date: boxing)
      boxing.available = 39
      boxing.save!
      available = boxing.available
      expect(boxing.waiting_lists.count).to eq 0
      delete :destroy, id: reservation.id
      expect(response).to be_success
      json = JSON.parse(response.body)
      expect(json['success']).to eq true
      expect(boxing.reload.reservations.count).to eq 0
      expect(boxing.reload.available).to eq available + 1
    end

    it "cancels class with  waiting list single" do
      user_waiting = FactoryGirl.create(:user, available_classes: 10)
      boxing = FactoryGirl.create(:class_date, date: '01-01-2018')
      reservation = FactoryGirl.create(:reservation, user: @api_key.user, class_date: boxing)
      waiting = FactoryGirl.create(:waiting_list, user: user_waiting, class_date: boxing)

      expect(boxing.waiting_lists.count).to eq 1
      delete :destroy, id: reservation.id
      expect(response).to be_success
      json = JSON.parse(response.body)
      expect(json['success']).to eq true
      expect(boxing.waiting_lists.count).to eq 0
      expect(boxing.reservations.reload.count).to eq 1
      expect(boxing.reload.reservations.first.user_id).to eq user_waiting.id
      expect(user_waiting.reload.available_classes).to eq 9
    end

    it "cancels class with  waiting list" do
      user_waiting = FactoryGirl.create(:user, available_classes: 10)
      user_second = FactoryGirl.create(:user)
      boxing = FactoryGirl.create(:class_date, date: '01-01-2018')
      reservation = FactoryGirl.create(:reservation, user: @api_key.user, class_date: boxing)
      waiting = FactoryGirl.create(:waiting_list, user: user_waiting, class_date: boxing)
      waiting_2 = FactoryGirl.create(:waiting_list, user: user_second, class_date: boxing)

      expect(boxing.waiting_lists.count).to eq 2
      delete :destroy, id: reservation.id
      expect(response).to be_success
      json = JSON.parse(response.body)
      expect(json['success']).to eq true
      expect(boxing.waiting_lists.count).to eq 1
      expect(boxing.reservations.reload.count).to eq 1
      expect(boxing.reload.reservations.first.user_id).to eq user_waiting.id
      expect(user_waiting.reload.available_classes).to eq 9
    end

  end


end
