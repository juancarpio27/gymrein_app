class Location < ApplicationRecord

  has_many :class_dates

  scope :find_by_fullname,->(name){ where("LOWER(name) LIKE ?", "%#{name}%")}


  self.per_page = 20
end
