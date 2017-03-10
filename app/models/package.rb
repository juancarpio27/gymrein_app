class Package < ApplicationRecord

  validates :name, presence: true
  validates :price, presence: true
  validates :classes, presence: true

  has_many :user_packages

  self.per_page = 20

end
