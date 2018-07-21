class Playlist
  belongs_to :user
  has_many :tracks

  attr_reader :name, :tracks_href, :user
  def initialize(data, user)
    @name = data[:name]
    @tracks_href = data[:tracks][:href]
    @user = user
  end

  def tracks
    playlist_tracks = TrackService.new(@tracks_href, user).tracks
    playlist_tracks.each do 
  end
end