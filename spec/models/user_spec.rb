require 'rails_helper'

RSpec.describe User, type: :model do
  it "has a valid factory" do
    FactoryGirl.create(:user).should be_valid
  end
  it "is invalid without email" do
    FactoryGirl.build(:user, email: nil).should_not be_valid
  end
  it "is invalid without name" do
    FactoryGirl.build(:user, name: nil).should_not be_valid
  end
  it "is invalid without lastname" do
    FactoryGirl.build(:user, lastname: nil).should_not be_valid
  end
  it "is invalid without phone" do
    FactoryGirl.build(:user, phone: nil).should_not be_valid
  end
  it "is invalid without birth" do
    FactoryGirl.build(:user, birth: nil).should_not be_valid
  end
  it "is invalid without sex" do
    FactoryGirl.build(:user, sex: nil).should_not be_valid
  end
  it "doesn't allow repeated email" do
    user = FactoryGirl.create(:user)
    FactoryGirl.build(:user, email: user.email).should_not be_valid
  end
  it "has secure password" do
    FactoryGirl.build(:user, password: "12345678", password_confirmation: "12345679").should_not be_valid
  end

  it "correctly update classes for 0 classes" do
    user = FactoryGirl.build(:user)
    user.update_classes(10)
    expect(user.available_classes).to eq 10
  end

  it "correctly update classes for 10 classes" do
    user = FactoryGirl.build(:user, available_classes: 10)
    user.update_classes(10)
    expect(user.available_classes).to eq 20
  end

  describe "find classes by time range" do
    before :each do
      @user = FactoryGirl.create(:user)

      @spinning = FactoryGirl.create(:class_date, date: '01-01-2017 10:00', duration: 60)
      @crossfit = FactoryGirl.create(:class_date, date: '01-02-2017 10:00', duration: 60)

      @reservation = FactoryGirl.create(:reservation, user: @user, class_date: @spinning)
      @waiting = FactoryGirl.create(:waiting_list, user: @user, class_date: @crossfit)
    end


    it "returns false for not overlapping class after" do
      expect(@user.has_existing_class('01-01-2017 14:00',60)).to eq false
    end
    it "returns false for not overlapping before" do
      expect(@user.has_existing_class('01-01-2017 08:00',60)).to eq false
    end
    it "returns false for not overlapping finish just before" do
      expect(@user.has_existing_class('01-01-2017 09:00',60)).to eq false
    end
    it "returns false for not overlapping starts just after" do
      expect(@user.has_existing_class('01-01-2017 11:00',60)).to eq false
    end
    it "returns true for overlapping class" do
      expect(@user.has_existing_class('01-01-2017 10:30',60)).to eq true
    end
    it "returns true for overlapping class starting at same time" do
      expect(@user.has_existing_class('01-01-2017 10:00',60)).to eq true
    end

    it "returns false for not overlapping class after waiting list" do
      expect(@user.has_existing_class('01-02-2017 14:00',60)).to eq false
    end
    it "returns false for not overlapping before waiting list" do
      expect(@user.has_existing_class('01-02-2017 08:00',60)).to eq false
    end
    it "returns false for not overlapping finish just before waiting list" do
      expect(@user.has_existing_class('01-02-2017 09:00',60)).to eq false
    end
    it "returns false for not overlapping starts just after waiting list" do
      expect(@user.has_existing_class('01-02-2017 11:00',60)).to eq false
    end
    it "returns true for overlapping class waiting list" do
      expect(@user.has_existing_class('01-02-2017 10:30',60)).to eq true
    end
    it "returns true for overlapping class starting at same time waiting list" do
      expect(@user.has_existing_class('01-02-2017 10:00',60)).to eq true
    end
  end
end
