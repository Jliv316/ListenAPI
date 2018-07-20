class Playlist
  attr_reader :name, :tracks_href, :user
  def initialize(data, user)
    @name = data[:name]
    @tracks_href = data[:tracks][:href]
    @user = user
  end

  def tracks
    TrackService.new(@tracks_href, user).tracks
  end
end