class Card < ApplicationRecord

  belongs_to :user

  validates :holder_name, presence: true
  validates :number, presence: true
  validates :expiration_month, presence: true
  validates :expiration_year, presence: true
  validates :brand, presence: true

  before_save :sanitize_params

  def sanitize_params
    self.number = self.number.last(4)
  end

end
