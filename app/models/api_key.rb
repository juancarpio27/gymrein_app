class ApiKey < ApplicationRecord

  before_create :generate_access_token

  belongs_to :user
  has_one :session, dependent: :nullify

  protected

  def generate_access_token
    begin
      self.access_token = SecureRandom.hex
    end while self.class.exists?(access_token: access_token)
  end

end
