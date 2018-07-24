class UserService
  def get_user_info(token_info)
    url = "https://api.spotify.com/v1/me"

    payload = {
        access_token: token_info["access_token"]
      }

      response = Faraday.get(url, payload)

      json = JSON.parse(response.body)
      user_info = token_info.merge(json)
      return user_info
  end
end