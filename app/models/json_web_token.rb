class JsonWebToken
  def self.encode(payload)
    # Expiration optional
    # @TODO: expire token with idle time duration instead of absolute time
    expiration = 60.minutes.from_now.to_i

    JWT.encode payload.merge(exp: expiration), Rails.application.credentials.secret_key_base
  end

  def self.decode(token)
    JWT.decode(token, Rails.application.credentials.secret_key_base).first
  end
end