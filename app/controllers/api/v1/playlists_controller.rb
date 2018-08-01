module Api::V1
  class PlaylistsController < ApplicationController
    skip_before_action :verify_authenticity_token
    def create
      current_user
      @playlists = current_user.playlists.to_json
      render json: @playlists
    end
  end
end