class WaitingList < ApplicationRecord

  belongs_to :user
  belongs_to :class_date

  def event
    self.class_date.event
  end

end
