class User < ApplicationRecord

  def playlists
    PlaylistService.new(self).playlists
  end

  def self.update_or_create(auth)
    user = User.find_by(uid: auth[:uid]) || User.new
    user.attributes = {
      provider: auth[:provider],
      uid: auth[:uid],
      email: auth[:info][:email],
      name: auth[:info][:name],
      token: auth[:credentials][:token],
      refresh_token: auth[:credentials][:refresh_token],
      token_exp: Time.at(auth[:credentials][:expires_at])
    }
    user.save!
    user
  end
end