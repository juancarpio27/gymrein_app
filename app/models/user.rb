class User < ApplicationRecord

  module Json
    SHOW = {only: [:id, :name, :lastname, :email, :phone, :birth, :sex, :avatar_file_name, :avatar_content_type], methods: [:access_token, :avatar_url]}
  end

  enum sex: [:female, :male]

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_attached_file :avatar, styles: {
                               thumb: '100x100>',
                               square: '200x200#',
                               medium: '300x300>'
                           },
                    default_url: 'https://gymrein.herokuapp.com/avatars/thumb/missing.png'
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  validates :name, presence: true, length: {in: 2..75}
  validates :lastname, presence: true, length: {in: 2..90}
  validates :phone, presence: true, length: {in: 1..14}
  validates :birth, presence: true
  validates :sex, presence: true

  has_many :api_keys
  has_many :sessions
  has_many :cards
  has_many :user_packages
  has_many :reservations
  has_many :waiting_lists

  has_many :class_dates, through: :reservations
  has_many :class_waiting, through: :waiting_lists, source: :class_date

  scope :search_by_email,->(email){ where("name || ' ' || lastname LIKE ?", "%#{email}%")}

  self.per_page = 20

  def access_token
    api_keys.first.nil? ? nil : api_keys.last.access_token
  end

  def full_name
    name + ' ' + lastname
  end

  def avatar_url
    self.avatar.url
  end

  def update_classes(n)
    self.available_classes = self.available_classes + n
    self.save!
  end

  def has_existing_class(time,duration)
    if time.is_a? String
      start = DateTime.parse(time)
    else
      start = time
    end

    finish_date = start + duration.minutes
    reservations = self.class_dates.where('date < ? and finish > ?',finish_date,start)
    waiting = self.class_waiting.where('date < ? and finish > ?',finish_date,start)
    reservations.any? or waiting.any?
  end

end
