class User < ApplicationRecord
  has_many :user_tracks
  has_many :tracks, through: :user_tracks
  has_many :playlists
  has_many :user_parties
  has_many :parties, through: :user_parties

  after_create :create_playlists, on: [:create, :update]

  def self.update_or_create(auth)
    auth["images"] << {"url" => "none"} if auth["images"] == []
    if auth[:client_token]
      client_token = auth[:client_token]
    else
      client_token = ClientToken.encode(auth["id"])
    end

    user = User.find_by(spotify_id: auth["id"]) || User.new
    user.attributes = {
      spotify_id: auth["id"],
      email: auth["email"],
      name: auth["display_name"],
      token: auth["access_token"],
      refresh_token: auth["refresh_token"],
      client_token: client_token,
      token_exp: auth["expires_in"].seconds.from_now,
      profile_picture: auth["images"][0]["url"]
    }
    user.save!
    user
  end

  def start_party(location)
    users = User.all
    # partiers = users.find_all do |user|
    #     user.location_data = location if user.location_data == {}
    #     lat = user.location_data["lat"]
    #     lng = user.location_data["lng"]
    #     (location["lat"] - lat).round(3) == 0.0
    # end
    return users
  end

  def top_tracks
    tracks.group(:name).order('count_all desc').count.first(10)
  end

  def mark_top_tracks
    TopTracksService.new(self).tracks
  end

  def find_common_tracks

  end



  private
  def create_playlists
    PlaylistService.new(self).playlists
  end


end