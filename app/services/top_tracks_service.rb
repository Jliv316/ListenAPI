class TopTracksService
  attr_reader :user
 def initialize(user)
    @user = check_token(user)
  end

  def check_token(user)
    token_service = TokenService.new(user)
    token_service.refresh_token_if_expired
  end

  def tracks
    data.map do |info|
      playlist = Playlist.create(name: "Top Songs", spotify_id: "none", user_id: @user.id, tracks_url: "none")

      artist = Artist.create(name: "none", spotify_id: "none") if info[:album][:artists] == ([] || nil)
      artist = Artist.create(name: info[:album][:artists][0][:name], spotify_id: info[:album][:artists][0][:id]) if info[:album][:artists] != ([] || nil)


      album = Album.create(name: info[:album][:name], spotify_id: info[:album][:id])
      track = Track.create(name: info[:name], spotify_id: info[:id], popularity: info[:popularity], artist_id: artist.id, album_id: album.id, release_date: info[:album][:release_date], playlist_id: playlist.id)
      UserTrack.create(user_id: @user.id, track_id: track.id, added_at: "none")
    end
  end

  private

  def response
    conn = Faraday.new(:url => "https://api.spotify.com") do |faraday|
      faraday.response :logger                  # log requests to STDOUT
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end

    response = conn.get do |req|
      req.url "v1/me/top/tracks?time_range=long_term"
      req.headers['Accept'] = "application/json"
      req.headers['Authorization'] = "Bearer #{@user.token}"
    end
  end
  
  def data
    json = JSON.parse(response.body, symbolize_names: true)
    json[:items]
  end
end