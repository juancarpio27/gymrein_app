class Promotion < ApplicationRecord

  enum promotion_type: [:percentage, :quantity]

  validates :code, presence: true
  validates :promotion_type, presence: true
  validates :expiration, presence: true
  validates :amount, presence: true

  has_many :user_packages

  self.per_page = 20


end
