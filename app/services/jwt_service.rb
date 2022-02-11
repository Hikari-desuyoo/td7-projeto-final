class JwtService
  def self.encode(payload)
    JWT.encode(payload, ENV['AUTH_JWT_SECRET'], 'HS256')
  end

  def self.decode(payload)
    JWT.decode(payload, ENV['AUTH_JWT_SECRET'], 'HS256')
  end
end
