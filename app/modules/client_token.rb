module ClientToken
  def self.encode(sub)
    payload = {
      iss: 'https://mighty-inlet-30984.herokuapp.com/',
      sub: sub,
      iat: Time.now.to_i
    }
    JWT.encode payload, 'ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ', 'HS256'
  end

  def self.decode(token)
    options = {
      iss: 'https://mighty-inlet-30984.herokuapp.com/',
      verify_iss: true,
      verify_iat: true,
      leeway: 30,
      algorithm: 'HS256'
    }
    JWT.decode token, 'ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ', true, options
  end
end