class ClassDate < ApplicationRecord

  belongs_to :instructor
  belongs_to :location
  belongs_to :event

  has_many :reservations
  has_many :waiting_lists

end
