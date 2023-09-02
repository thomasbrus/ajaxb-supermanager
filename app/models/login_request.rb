class LoginRequest < ApplicationRecord
  belongs_to :contestant
  before_create :set_validation_key, :set_expires_at

  private def set_validation_key
    self.validation_key = SecureRandom.hex.to_s
  end

  private def set_expires_at
    self.expires_at = 24.hours.from_now
  end
end
