FactoryGirl.define do
  factory :user_package do
    association :user, factory: :user
    association :card, factory: :card
    association :package, factory: :package
    association :promotion, factory: :promotion
    price 200
  end
end
