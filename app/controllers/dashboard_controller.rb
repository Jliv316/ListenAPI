class DashboardController < ApplicationController
  before_action :authenticate_user!
  def show
    @playlists = current_user.playlists
    @tracks = current_user.tracks
  end
end