class Event < ApplicationRecord
  self.per_page = 20

  has_attached_file :logo, styles: {
                               thumb: '100x100>',
                               square: '200x200#',
                               medium: '300x300>'
                           }
  validates_attachment_content_type :logo, content_type: /\Aimage\/.*\z/

  has_many :class_dates, dependent: :destroy

  scope :find_by_fullname,->(name){ where("LOWER(name) LIKE ?", "%#{name}%")}

  def logo_url
    self.logo.url
  end
end
