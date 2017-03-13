class Location < ApplicationRecord

  has_many :class_dates

  self.per_page = 20
end
