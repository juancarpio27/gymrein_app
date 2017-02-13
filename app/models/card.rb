class Card < ApplicationRecord

  belongs_to :user

  validates :holder_name, presence: true
  validates :number, presence: true
  validates :expiration_month, presence: true
  validates :expiration_year, presence: true
  validates :brand, presence: true

end
