class PlaylistService
  def initialize(user)
    @user = check_token(user)
  end

  def check_token(user)
    token_service = TokenService.new(user)
    token_service.refresh_token_if_expired
  end

  def playlists
    user_playlists = data.map do |info|
      playlist = @user.playlists.create(name: info[:name], user_id: @user.id, spotify_id: info[:id], tracks_url: info[:tracks][:href])
      TrackService.new(@user, info[:tracks][:href], playlist.id).tracks
      # TopTracksService.new(@user).tracks
    end
    return user_playlists
  end

  private
  def conn
    Faraday.new("https://api.spotify.com")
  end

  def response
    conn.get "/v1/me/playlists" do |request|
      request.params["access_token"] = @user.token
    end
  end
  
  def data
    json = JSON.parse(response.body, symbolize_names: true)
    json[:items]
  end
end