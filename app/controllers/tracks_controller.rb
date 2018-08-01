class PlaylistsController < ApplicationController
  before_action :authenticate_user!

  def index
    @tracks = current_user.tracks
  end

  def show
    @track = current_user.tracks.find(params[:id])
  end
end