class Promotion < ApplicationRecord

  enum promotion_type: [:percentage, :quantity]

  validates :code, presence: true
  validates :promotion_type, presence: true
  validates :expiration, presence: true
  validates :amount, presence: true

  scope :find_by_fullname,->(code){ where("code LIKE ?", "%#{code}%")}


  has_many :user_packages

  self.per_page = 20


end
