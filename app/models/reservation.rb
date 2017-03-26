class Reservation < ApplicationRecord

  belongs_to :user
  belongs_to :class_date

  scope :checked_in, -> {where(assisted: true)}

  self.per_page = 20

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

  def class_date_name
    self.class_date.event
  end

  def class_date_logo
    self.class_date.event.logo_url
  end

  def check_in
    self.assisted = true
    self.save!
  end

  def event
    self.class_date.event
  end

end
