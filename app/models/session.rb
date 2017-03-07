class Session < ApplicationRecord

  enum platform: [:android, :ios]

  belongs_to :user
  belongs_to :api_key

  validates :platform, presence: true

  scope :exclude, ->(id) { where.not(id: id) }
  scope :active, -> { where(deleted_at: nil) }

  after_create :delete_previous_session

  def delete!
    update!(deleted_at: Time.now)
    api_key.destroy! unless api_key.nil?
  end

  def delete_previous_session
    transaction do
      user.sessions.active.exclude(self.id).each do |session|
        session.delete!
      end
    end
  end

end
