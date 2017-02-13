FactoryGirl.define do
  factory :api_key do
    access_token "MyString"
    association :user, factory: :user
  end
end
