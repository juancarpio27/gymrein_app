FactoryGirl.define do
  factory :session do
    platform 1
    association :user, factory: :user
    association :api_key, factory: :api_key
  end
end
