class Session < ApplicationRecord

  enum platform: [:android, :ios]

  belongs_to :user
  belongs_to :api_key

  validates :platform, presence: true

  after_create :delete_previous

  def delete_previous
    Session.where.not(id: self.id).where(user_id: self.id).destroy_all
  end

end
