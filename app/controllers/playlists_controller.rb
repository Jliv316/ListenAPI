class PlaylistsController < ApplicationController
  before_action :authenticate_user!

  def index
    @playlists = current_user.playlists
  end

  def show
    @playlist = current_user.playlists.find(params[:id])
  end

end