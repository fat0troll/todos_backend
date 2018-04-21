module ControllerSpecHelper
  # Generate token for user
  def token_generator(user_id)
    JsonWebToken.encode(user_id: user_id)
  end

  # Generate expired token for user
  def expired_token_generator(user_id)
    JsonWebToken.encode({ user_id: user_id }, (Time.now.to_i - 10))
  end

  # This is valid authorization headers
  def valid_headers
    {
      "Authorization" => token_generator(user.id),
      "Content-Type" => "application/json"
    }
  end

  # This is invalid authorization headers
  def invalid_headers
    {
      "Authorization" => nil,
      "Content-Type" => "application/json"
    }
  end
end