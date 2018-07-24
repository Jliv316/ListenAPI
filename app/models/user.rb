class User < ApplicationRecord
  has_many :user_tracks
  has_many :tracks, through: :user_tracks
  has_many :playlists

  after_create :create_playlists, on: [:create, :update]

  def self.update_or_create(auth)
    user = User.find_by(spotify_id: auth[:spotify_id]) || User.new
    user.attributes = {
      spotify_id: auth["id"],
      email: auth["email"],
      name: auth["display_name"],
      token: auth["access_token"],
      refresh_token: auth["refresh_token"],
      token_exp: Time.at(auth["expires_in"])
    }
    user.save!
    user
  end

  private
  def create_playlists
    PlaylistService.new(self).playlists
  end
end