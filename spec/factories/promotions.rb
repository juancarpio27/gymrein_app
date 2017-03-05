FactoryGirl.define do
  factory :promotion do
    code "dDQ41D"
    promotion_type { Faker::Number.between(0,1) }
    expiration "2018-01-01"
    amount 20
    
  end
end
