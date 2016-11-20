module V1
  class ArtistsController < ApplicationController
    before_action :set_artist, only: [:show, :update, :destroy]

    # Enables authentication for this controller.
    # before_action :check_for_api_token

    # GET /artists
    def index
      @artists = Artist.all
      render json: serialize(@artists)
    end

    # GET /artists/1
    def show
      render json: serialize(@artist)
    end

    # POST /artists
    def create
      @artist = Artist.new(artist_params)

      if @artist.save
        render json: serialize_artist(@artist), status: :created, location: v1_artist_url(@artist)
      else
        render json: {
          errors: @artist.errors, status: :unprocessable_entity
        }
      end
    end

    # PATCH/PUT /artists/1
    def update
      if @artist.update(artist_params)
        render json: serialize(@artist)
      else
        render json: {
          errors: @artist.errors
        }, status: :unprocessable_entity
      end
    end

    # DELETE /artists/1
    def destroy
      @artist.destroy
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_artist
      @artist = Artist.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def artist_params
      params.require(:artist).permit(:name)
    end

    # Wrapper/router for serializers. 
    def serialize(resource)
      if resource.respond_to?(:each)
        serialize_artists(resource)
      else
        serialize_artist(resource)
      end
    end

    # Custom serializer for artists index route.
    def serialize_artists(artists) 
      json = "{["
      artists.each do |artist|
        json += "{\"id\": \"#{artist.id}\",
        \"name\": \"#{artist.name}\"}"
        json += "," unless artist == artists.last
      end
      json += "]}"
    end

    # Serialize just one artist.
    def serialize_artist(artist)
      json = "{\"id\": \"#{artist.id}\",
      \"name\": \"#{artist.name}\"}"
    end       
  end
end 