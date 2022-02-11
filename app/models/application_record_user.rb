class ApplicationRecordUser < ApplicationRecord
  self.abstract_class = true

  def self.user_by_credentials(credentials)
    user = find_by(email: credentials['email'])
    user&.valid_password?(credentials['password']) ? user : nil
  end

  def self.user_by_jwt(jwt)
    return nil if jwt.nil?

    decoded = JwtService.decode jwt
    find_by(email: decoded.first['sub'])
  end

  def user_jwt
    payload = {
      sub: email,
      exp: Time.now.to_i + 4 * 3600
    }

    JwtService.encode payload
  end
end
