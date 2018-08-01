require 'base64'

class TokenService
  attr_reader :user
  def initialize(user = nil)
    @user = user
  end

  def get_access_token(code)
    url = "https://accounts.spotify.com/api/token"

    payload = {
        grant_type: "authorization_code", 
        redirect_uri: "https://evening-river-55715.herokuapp.com/auth/spotify/callback",
        code: code,
        client_id: ENV['SPOTIFY_CLIENT_ID'],
        client_secret: ENV['SPOTIFY_CLIENT_SECRET']
      }

      response = Faraday.post(url, payload)

      json = JSON.parse(response.body)
  end

  def refresh_token_if_expired
    if token_expired?
      url = "https://accounts.spotify.com/api/token"

      payload = {
        grant_type: "refresh_token", 
        refresh_token: user.refresh_token,
        client_id: ENV['SPOTIFY_CLIENT_ID'],
        client_secret: ENV['SPOTIFY_CLIENT_SECRET']
      }
      response = Faraday.post(url, payload)

      json = JSON.parse(response.body)

      user.token = json["access_token"]
      user.token_exp = json["expires_at"]

      user.save
      return user
    else
      return user
    end
  end

  def token_expired?
    user.token_exp = 10.minutes.ago if user.token == nil
    if user.token_exp < Time.now
      return true
    else
      return false
    end
  end
end