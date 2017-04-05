class WaitingList < ApplicationRecord

  belongs_to :user
  belongs_to :class_date

  self.per_page = 20

  module Json

    SHOW = {
        include: {
            class_date: {
                methods: [:logo_url, :event, :location,:avatar_url, :instructor]
            }
        }
    }

    LIST = {
        include: {
            class_date: {
                methods: [:logo_url, :event, :location, :avatar_url, :instructor]
            }
        }
    }
  end

  def event
    self.class_date.event
  end

end
