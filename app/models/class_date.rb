class ClassDate < ApplicationRecord

  belongs_to :instructor
  belongs_to :location
  belongs_to :event

  has_many :reservations
  has_many :waiting_lists

  before_save :calculate_finish

  module Json

    SHOW = {
        include: {
            event: {
                methods: [:logo_url]
            },
            location: {

            },
            instructor: {

            }
        }
    }

    LIST = {
        include: {
            event: {
                methods: [:logo_url]
            },
            location: {

            },
            instructor: {

            }
        }
    }
  end

  def calculate_finish
    self.finish = self.date + self.duration.minutes
  end

  def logo_url
    self.event.logo_url
  end

  def new_class
    self.available = self.available - 1
    self.save!
  end

  def recover_class
    self.available = self.available + 1
    self.save!
  end

end
