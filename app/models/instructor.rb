class Instructor < ApplicationRecord

  self.per_page = 20

  has_attached_file :avatar, styles: {
                               thumb: '100x100>',
                               square: '200x200#',
                               medium: '300x300>'
                           }
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  validates :name, presence: true
  validates :lastname, presence: true

  def full_name
    name + ' ' + lastname
  end
end
