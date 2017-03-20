FactoryGirl.define do
  factory :class_date do
    association :event, factory: :event
    association :instructor, factory: :instructor
    association :location, factory: :location
    date '10-01-2017 10:00'
    room '128A'
    duration 120
    limit 75
    available 75
  end
end
