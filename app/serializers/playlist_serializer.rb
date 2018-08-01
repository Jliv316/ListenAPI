class PlaylistSerializer < ActiveModel::Serializer
  attributes :playlist_id, :user_id, :access_token, :tracks

  def playlist_id
    object.spotify_id
  end

  def user_id
    user = User.find(object.user_id)
    return user.spotify_id
  end

  def access_token
    user = User.find(object.user_id)
    return user.token
  end

  def tracks
    tracks = object.tracks.map do |track|
      track
    end
    return tracks
  end
end