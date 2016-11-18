class ApiKey < ApplicationRecord
  before_create :generate_token, :generate_expiry

  private

  def generate_token
    begin
      self.token = SecureRandom.hex
    end while self.class.exists?(token: token)
  end

  def generate_expiry
    # Set the expiration date to 3 days from now.
    # I picked this period randomly.
    self.expiry = DateTime.now + 3
  end
end
