FactoryGirl.define do
  factory :waiting_list do
    association :user, factory: :user
    association :class_date, factory: :class_date
  end
end
