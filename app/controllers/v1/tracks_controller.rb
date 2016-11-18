module V1
  class TracksController < ApplicationController
    before_action :set_track, only: [:show, :update, :destroy]

    # Token-based authentication. To disable, remove these lines.
    include ActionController::HttpAuthentication::Token::ControllerMethods
    before_action :restrict_access

    # GET /tracks
    def index
      @tracks = Track.all

      render json: @tracks
    end

    # GET /tracks/1
    def show
      render json: @track
    end

    # The Postman request for creating a track should look like this:

    # POST http://localhost:3000/v1/tracks 
    # Headers: Authorization | Token token=10f251790e0d2d5d7a12f93b5caedd10
    # Body: [x] form-data

    # track[name]   | Sexy Back               | text
    # track[artist] | Justin Timberlake       | text
    # track[title]  | Future Sex Love Sounds  | text
    # track[file]   | Choose file             | file

    # POST /tracks
    def create
      @track = Track.new(track_params)

      if @track.save
        render json: @track, status: :created, location: v1_track_url(@track)
      else
        render json: @track.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /tracks/1
    def update
      if @track.update(track_params)
        render json: @track
      else
        render json: @track.errors, status: :unprocessable_entity
      end
    end

    # DELETE /tracks/1
    def destroy
      @track.destroy
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_track
      @track = Track.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def track_params
      params.require(:track).permit(:name, :artist, :release, :file)
    end

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
end 