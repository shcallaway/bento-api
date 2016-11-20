class ApplicationController < ActionController::API

  # This is necessary for 'authenticate_or_request_with_http_token'.
  include ActionController::HttpAuthentication::Token::ControllerMethods

  private

  # Check if api key exists, and is not expired.
  def restrict_access
    authenticate_or_request_with_http_token do |token, options|
      key_exists = ApiKey.exists?(token: token)

      # If the key exists, check to see if it's expired.
      if key_exists
        
        # If expiry date is later than right now, return true.
        key_expiry = ApiKey.where(token: token).first.expiry
        return true if key_expiry > DateTime.now
      end

      # If the key doesn't exist, or is expired, return false.
      false
    end
  end  
end
