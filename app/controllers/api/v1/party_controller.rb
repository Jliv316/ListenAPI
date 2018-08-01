module Api::V1
  class PartyController < ApplicationController
    skip_before_action :verify_authenticity_token
    def create
      current_user = User.find_by(client_token: params[:client_token])
      party = current_user.start_party(current_user.location_data)
        @top_tracks = party.map do |user|
          user.top_tracks.map do |track|
            track[0]
          end
        end
      @top_tracks = @top_tracks.flatten.uniq
      top_tracks = User.get_tracks(@top_tracks)
      playlist = CreatePlaylistService.new(current_user).create_playlist
      AddTracksService.new(current_user, playlist, top_tracks).format_tracks
      render json: playlist
    end
  end
end