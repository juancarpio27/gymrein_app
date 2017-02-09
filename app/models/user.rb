class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  validates :name, presence: true, length: {in: 2..75}
  validates :lastname, presence: true, length: {in: 2..90}

  has_many :api_keys
  has_many :sessions
  has_many :cards

  def access_token
    api_keys.first.nil? ? nil : api_keys.last.access_token
  end

end
