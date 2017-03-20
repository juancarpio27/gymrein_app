FactoryGirl.define do
  factory :reservation do
    association :user, factory: :user
    association :class_date, factory: :class_date
  end
end
