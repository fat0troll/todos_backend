class AuthorizeAPIRequest
  def initialize(headers = {})
    @headers = headers
  end

  # From here it goes.
  # In proper authorization sequense we should return User
  def call
    {
      user: user
    }
  end

  private

  attr_reader :headers

  def user
    @user ||= User.find(decoded_auth_token[:user_id]) if decoded_auth_token
  rescue ActiveRecord::RecordNotFound => e
    # We don't need ActiveRecord error, but need our custom one
    raise(
      Exceptions::InvalidToken,
      ("#{Message.invalid_token} #{e.message}")
    )
  end

  def decoded_auth_token
    @decoded_auth_token ||= JsonWebToken.decode(http_auth_header)
  end

  def http_auth_header
    if headers['Authorization'].present?
      return headers['Authorization'].split(' ').last
    end
    # Whoa, no tokens. Silly.
    raise(Exceptions::MissingToken, Message.missing_token)
  end
end