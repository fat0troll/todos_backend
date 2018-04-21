class JsonWebToken
  # We'll use standard 'secret key base' as decode/encode for JWT
  HMAC_SECRET = Rails.application.credentials.secret_key_base

  def self.encode(payload, exp = 72.hours.from_now)
    # Tokens will expire in 3 days
    payload[:exp] = exp.to_i
    # Encode token with secret
    JWT.encode(payload, HMAC_SECRET)
  end

  def self.decode(token)
    # Grab token
    body = JWT.decode(token, HMAC_SECRET)[0]
    HashWithIndifferentAccess.new body
  rescue JWT::DecodeError => e
    raise Exceptions::InvalidToken, e.message
  end
end