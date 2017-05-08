class Location < ApplicationRecord

  has_many :class_dates, dependent: :destroy

  scope :find_by_fullname,->(name){ where("LOWER(name) LIKE ?", "%#{name}%")}

  self.per_page = 20


  def future_classes
    self.class_dates.where('date > ?', Time.now - 6.hours)
  end

end
