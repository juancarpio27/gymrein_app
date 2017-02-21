class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_attached_file :avatar, styles: {
                               thumb: '100x100>',
                               square: '200x200#',
                               medium: '300x300>'
                           }
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  validates :name, presence: true, length: {in: 2..75}
  validates :lastname, presence: true, length: {in: 2..90}
  validates :phone, presence: true, length: {in: 1..14}

  has_many :api_keys
  has_many :sessions
  has_many :cards

  self.per_page = 20

  def access_token
    api_keys.first.nil? ? nil : api_keys.last.access_token
  end

  def full_name
    name + ' ' + lastname
  end

end
