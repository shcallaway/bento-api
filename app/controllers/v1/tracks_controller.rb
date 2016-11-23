module V1
  class TracksController < ApplicationController
    before_action :set_track, only: [:show, :update, :destroy]
    
    # Enables authentication for this controller.
    # before_action :check_for_api_token

    # GET /tracks
    def index
      @tracks = Track.all
      render json: serialize(@tracks)
    end

    # GET /tracks/1
    def show
      render json: serialize(@track)
    end

    # POST /tracks
    def create
      # Create a new track, without any attributes.
      @track = Track.new

      # Populate attributes via params.
      @track.name = track_params[:name]
      @track.file = track_params[:file]

      # Look for an artist with the supplied artist name.
      # If it exists, assign it to the track.
      if Artist.exists?(name: track_params[:artist])
        @track.artist = Artist.where(name: track_params[:artist]).first
      else 
        # If it does not exist, create a new artist with the name.
        @track.artist = Artist.new(name: track_params[:artist])
        # Check the new artist for validity; Render artist errors if invalid.
        return render json: {
          errors: @track.artist.errors
        }, status: :unprocessable_entity unless @track.artist.valid?
      end

      # Look for a release with the supplied release name, as well as
      # the supplied artist name. If it exists, assign it to the track.
      if Release.exists?(name: track_params[:release], artist: @track.artist)
        @track.release = Release.where(name: track_params[:release], artist: @track.artist).first
      else
        # If it does not exist, create a new release with the supplied name and artist.
        @track.release = Release.new(name: track_params[:release], artist: @track.artist)
        # Check the new release for validity; Render release errors if invalid.
        return render json: {
          errors: @track.release.errors
        }, status: :unprocessable_entity unless @track.release.valid?
      end

      # Attempt to save the track.
      if @track.save
        render json: serialize(@track), status: :created, location: v1_track_url(@track)
      else
        render json: {
          errors: @track.errors
        }, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /tracks/1
    def update
      if @track.update(track_params)
        render json: serialize(@track)
      else
        render json: { 
          errors: @track.errors
        }, status: :unprocessable_entity
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

    # Wrapper/router for serializers. 
    def serialize(resource)
      if resource.respond_to?(:each)
        serialize_tracks(resource)
      else
        serialize_track(resource)
      end
    end

    # Custom serializer for tracks index route. 
    # (I was tired of fighting ActiveModel Serializer to get what I wanted.)
    def serialize_tracks(tracks)
      json = "{["
      # Add each track to the JSON.
      tracks.each do |track|
        json += serialize_track(track)
        # Add a comma if there are more tracks.
        json += "," unless track == tracks.last
      end
      # Close out the JSON and return.
      json += "]}"
    end

    # Serialize just one track.
    def serialize_track(track)
      json = "{\"id\": #{track.id},
      \"name\": \"#{track.name}\",
      \"artist\": {\"id\": #{track.artist.id},\"name\": \"#{track.artist.name}\"},
      \"release\": {\"id\": #{track.release.id},\"name\": \"#{track.release.name}\"},
      \"file\": \"#{track.file.url}\"}"
    end    
  end
end 