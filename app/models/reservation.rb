class Reservation < ApplicationRecord

  belongs_to :user
  belongs_to :class_date

  scope :checked_in, -> {where(assisted: true)}

  self.per_page = 20

  before_destroy :return_class

  module Json

    SHOW = {
        include: {
            class_date: {
                methods: [:logo_url, :event, :location, :avatar_url]
            }
        }
    }

    LIST = {
        include: {
            class_date: {
                methods: [:logo_url, :event, :location, :avatar_url]
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

  def return_class
    if self.class_date.date > Time.now - 6.hours
      self.user.update_classes(1)
    end
  end

end
