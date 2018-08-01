module ClientToken
  def self.encode(sub)
    payload = {
      iss: 'https://mighty-inlet-30984.herokuapp.com/',
      sub: sub,
      iat: Time.now.to_i
    }
    JWT.encode payload, ENV['JWT_SECRET'], 'HS256'
  end

  def self.decode(token)
    options = {
      iss: 'https://mighty-inlet-30984.herokuapp.com/',
      verify_iss: true,
      verify_iat: true,
      leeway: 30,
      algorithm: 'HS256'
    }
    JWT.decode token, ENV['JWT_SECRET'], true, options
  end
end