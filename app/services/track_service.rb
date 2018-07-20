class TrackService
  def initialize(tracks_href, user)
    @tracks_href = tracks_href
    @user = user
  end

  def tracks
    songs = data.map do |song|
      song[:track][:name]
    end
    return songs
  end

  private
  attr_reader :tracks_href

  def response
      payload = {
        access_token: @user.token
      }
      response = Faraday.get(tracks_href, payload)
  end
  
  def data
    json = JSON.parse(response.body, symbolize_names: true)
    json[:items]
  end
end