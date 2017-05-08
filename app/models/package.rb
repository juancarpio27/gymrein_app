class Package < ApplicationRecord

  validates :name, presence: true
  validates :price, presence: true
  validates :classes, presence: true

  has_many :user_packages

  scope :active, -> { where(deleted_at: nil) }

  scope :find_by_fullname,->(name){ where("LOWER(name) LIKE ?", "%#{name}%")}


  self.per_page = 20

end
