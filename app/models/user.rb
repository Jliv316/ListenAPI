class User < ApplicationRecord
  has_many :user_tracks
  has_many :tracks, through: :user_tracks
  has_many :playlists

  after_create :create_playlists, on: [:create, :update]

  def self.update_or_create(auth)
    user = User.find_by(spotify_id: auth[:spotify_id]) || User.new
    user.attributes = {
      provider: auth[:provider],
      spotify_id: auth[:uid],
      email: auth[:info][:email],
      name: auth[:info][:name],
      token: auth[:credentials][:token],
      refresh_token: auth[:credentials][:refresh_token],
      token_exp: Time.at(auth["credentials"]["expires_at"])
    }
    user.save!
    user
  end

  private
  def create_playlists
    PlaylistService.new(self).playlists
  end
end