class User < ApplicationRecord
  has_many :user_tracks
  has_many :tracks, through: :user_tracks
  has_many :playlists

  after_create :create_playlists, on: [:create, :update]

  def self.update_or_create(auth)
    client_token = ClientToken.encode(auth["id"])
    user = User.find_by(client_token: client_token) || User.new
    user.attributes = {
      spotify_id: auth["id"],
      email: auth["email"],
      name: auth["display_name"],
      token: auth["access_token"],
      refresh_token: auth["refresh_token"],
      client_token: client_token,
      token_exp: Time.at(auth["expires_in"]),
      profile_picture: auth["images"][0]["url"]
    }
    user.save!
    user
  end

  private
  def create_playlists
    PlaylistService.new(self).playlists
  end
end