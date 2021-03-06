require 'faker'

FactoryGirl.define do
  factory :user do |u|
    u.name { Faker::Name.first_name }
    u.lastname { Faker::Name.last_name }
    u.email { Faker::Internet.email }
    u.password "12345678"
    u.password_confirmation "12345678"
    u.phone "5512341234"
    u.sex { Faker::Number.between(0,1) }
    u.birth "01-01-2016"
    u.available_classes 0
  end
end
