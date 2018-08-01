class CreatePlaylistService
  attr_reader :user
  def initialize(user)
    @user = check_token(user)
  end

  def check_token(user)
    token_service = TokenService.new(user)
    token_service.refresh_token_if_expired
  end

  def create_playlist
    info = JSON.parse(response.body, symbolize_names: true)
    playlist = user.playlists.create(name: info[:name], user_id: @user.id, spotify_id: info[:id], tracks_url: info[:tracks][:href])
    return playlist
  end

  private
  def response
    conn = Faraday.new(:url => "https://api.spotify.com") do |faraday|
      faraday.response :logger                  # log requests to STDOUT
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end

    response = conn.post do |req|
      req.url "v1/users/#{user.spotify_id}/playlists"
      req.headers['Accept'] = "application/json"
      req.headers['Authorization'] = "Bearer #{@user.token}"
      req.body = {"name" => "Dynamic Playlist"}.to_json
    end
  end
  
  def data
    json = JSON.parse(response.body, symbolize_names: true)
  end
end