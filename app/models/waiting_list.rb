class WaitingList < ApplicationRecord

  belongs_to :user
  belongs_to :class_date

end
