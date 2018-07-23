class TrackService
  attr_reader :user, :playlist_id
  def initialize(user, tracks_url, playlist_id)
    @tracks_url = tracks_url
    @user = user
    @playlist_id = playlist_id
  end

  def tracks
    data.map do |info|
      artist = Artist.create(name: info[:track][:album][:name], spotify_id: info[:track][:album][:id])
      album = Album.create(name: info[:track][:album][:artists][0][:name], spotify_id: info[:track][:album][:artists][0][:id])
      track = Track.create(name: info[:track][:name], spotify_id: info[:track][:id], popularity: info[:track][:popularity], artist_id: artist.id, album_id: album.id, release_date: info[:track][:album][:release_date], playlist_id: playlist_id)
      UserTrack.create(user_id: user.id, track_id: track.id, added_at: info[:added_at])
    end
  end
  
  private
  attr_reader :tracks_url
  

  def response
      payload = {
        access_token: @user.token
      }
      response = Faraday.get(tracks_url, payload)
  end
  
  def data
    json = JSON.parse(response.body, symbolize_names: true)
    json[:items]
  end
end