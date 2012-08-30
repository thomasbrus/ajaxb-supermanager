class LoginRequest < ActiveRecord::Base
  belongs_to :contestant
  attr_accessible :expires_at, :validation_key
  before_create :set_validation_key, :set_expires_at
    
  protected
    def set_validation_key
      self.validation_key = SecureRandom.hex.to_s
    end
    
    def set_expires_at
      self.expires_at = 24.hours.from_now
    end
end
