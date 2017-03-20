class Reservation < ApplicationRecord

  belongs_to :user
  belongs_to :class_date

  def class_date_name
    self.class_date.event
  end

  def class_date_logo
    self.class_date.event.logo_url
  end

end
