class ApiKey < ApplicationRecord
  before_create :generate_token, :generate_expiry

  private

  def generate_token
    begin
      self.token = SecureRandom.hex
    end while self.class.exists?(token: token)
  end

  def generate_expiry
    self.expiry = DateTime.now + 3
  end
end
