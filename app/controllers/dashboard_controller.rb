class DashboardController < ApplicationController
  def show
    @playlists = current_user.playlists
  end
end