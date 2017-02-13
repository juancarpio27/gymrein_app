FactoryGirl.define do
  factory :card do
    holder_name { Faker::Name.first_name }
    number "1234"
    expiration_month { Faker::Number.between(1, 12) }
    expiration_year { Faker::Number.between(16, 24) }
    brand "Visa"
    association :user, factory: :user
  end
end
