module V1
  class ApiKeysController < ApplicationController

    # When the client app loads, it should make an 
    # asynchronous call to POST /v1/api_keys and capture
    # the token that returns. 

    def create
      @api_key = ApiKey.create!
      render json: @api_key, status: :created
    end
  end
end 
