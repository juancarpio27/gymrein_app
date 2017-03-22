class ClassDate < ApplicationRecord

  belongs_to :instructor
  belongs_to :location
  belongs_to :event

  has_many :reservations
  has_many :waiting_lists

  before_save :calculate_finish

  def calculate_finish
    self.finish = self.date + self.duration.minutes
  end

  def new_class
    self.available = self.available - 1
    self.save!
  end

end
