module V1
  class TracksController < ApplicationController
    before_action :set_track, only: [:show, :update, :destroy]
    
    # Enables authentication for this controller.
    # before_action :restrict_access

    # GET /tracks
    def index
      @tracks = Track.all

      render json: @tracks
    end

    # GET /tracks/1
    def show
      render json: @track
    end

    # POST /tracks
    def create
      # Create a new track, without any attributes.
      @track = Track.new

      # Populate attributes via params.
      @track.name = track_params[:name]
      @track.release = track_params[:release]
      @track.file = track_params[:file]

      # Look for an artist with the supplied artist_name. 
      # If it exists, assign it to the track.
      if Artist.exists?(name: track_params[:artist_name])
        @track.artist = Artist.where(name: track_params[:artist_name])
      else 
        # If it does not exist, create a new artist with the name.
        @track.artist = Artist.new(name: track_params[:artist_name])
      end

      # Attempt to save the new track.
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
      params.require(:track).permit(:name, :artist_name, :release, :file)
    end
  end
end 