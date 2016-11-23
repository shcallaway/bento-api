module V1  
  class ReleasesController < ApplicationController
    before_action :set_release, only: [:show, :update, :destroy]

    # Enables authentication for this controller.
    # before_action :check_for_api_token

    # GET /releases
    def index
      @releases = Release.all
      render json: serialize(@releases)
    end

    # GET /releases/1
    def show
      render json: serialize(@release)
    end

    # POST /releases
    def create
      @release = Release.new(release_params)

      if @release.save
        render json: serialize_release(@release), status: :created, location: v1_release_url(@release)
      else
        render json: {
          errors: @release.errors, status: :unprocessable_entity
        }
      end
    end

    # PATCH/PUT /releases/1
    def update
      if @release.update(release_params)
        render json: serialize(@release)
      else
        render json: {
          errors: @release.errors
        }, status: :unprocessable_entity
      end
    end

    # DELETE /releases/1
    def destroy
      @release.destroy
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_release
      @release = Release.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def release_params
      params.require(:release).permit(:name)
    end

    # Wrapper/router for serializers. 
    def serialize(resource)
      if resource.respond_to?(:each)
        serialize_releases(resource)
      else
        serialize_release(resource)
      end
    end

    # Custom serializer for releases index route.
    def serialize_releases(releases) 
      json = "{["
      releases.each do |release|
        json += serialize_release(release)
        json += "," unless release == releases.last
      end
      json += "]}"
    end

    # Serialize just one release.
    def serialize_release(release)
      json = "{\"id\": #{release.id},
      \"name\": \"#{release.name}\",
      \"artist\": {\"id\": #{release.artist.id},\"name\": \"#{release.artist.name}\"}}"
    end       
  end
end
