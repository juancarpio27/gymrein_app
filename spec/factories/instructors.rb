FactoryGirl.define do
  factory :instructor do
    name { Faker::Name.first_name }
    lastname { Faker::Name.last_name }
    biography "My Biography"
  end
end
