class Session < ApplicationRecord

  enum platform: [:android, :ios]

  belongs_to :user
  belongs_to :api_key


end