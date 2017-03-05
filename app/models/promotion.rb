class Promotion < ApplicationRecord

  enum promotion_type: [:percentage, :quantity]

  validates :code, presence: true
  validates :promotion_type, presence: true
  validates :expiration, presence: true
  validates :amount, presence: true

  self.per_page = 20


end
