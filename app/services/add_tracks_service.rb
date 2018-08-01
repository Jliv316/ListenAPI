class AddTracksService
  attr_reader :user, :playlist, :tracks
  def initialize(user, playlist, tracks)
    @user = user
    @playlist = playlist
    @tracks = tracks
  end

  def format_tracks
    track_array = tracks.map do |track|
      track.playlist_id = playlist.id
      track.save
      "spotify:track:#{track.spotify_id}"
    end
    response(track_array.to_json)
  end
  
  private

  private
  def response(tracks)
    conn = Faraday.new(:url => "https://api.spotify.com") do |faraday|
      faraday.response :logger                  # log requests to STDOUT
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end
    
    response = conn.post do |req|
      req.url "v1/users/#{user.spotify_id}/playlists/#{playlist.spotify_id}/tracks"
      req.headers['Accept'] = "application/json"
      req.headers['Authorization'] = "Bearer #{@user.token}"
      req.body = tracks
    end
  end
  
  def data
    json = JSON.parse(response.body, symbolize_names: true)
  end
end