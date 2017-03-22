class WaitingList < ApplicationRecord

  belongs_to :user
  belongs_to :class_date

  module Json

    SHOW = {
        include: {
            class_date: {
                methods: [:logo_url, :event, :location]
            }
        }
    }

    LIST = {
        include: {
            class_date: {
                methods: [:logo_url, :event, :location]
            }
        }
    }
  end

  def event
    self.class_date.event
  end

end
