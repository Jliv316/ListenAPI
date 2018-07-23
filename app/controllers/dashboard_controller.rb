class DashboardController < ApplicationController
  def show
    @playlists = current_user.playlists
    @tracks = current_user.tracks
  end
end