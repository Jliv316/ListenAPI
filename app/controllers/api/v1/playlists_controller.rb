module Api::V1
  class PlaylistsController < ApplicationController
    def index
      current_user
      @playlists = User.all.last.playlists.to_json
      render json: @playlists
    end
  end
end