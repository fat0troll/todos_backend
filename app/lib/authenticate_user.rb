class AuthenticateUser
  def initialize(email, password)
    @email = email
    @password = password
  end

  # So, here we are
  def call
    JsonWebToken.encode(user_id: user.id) if user
  end

  private

  attr_reader :email, :password

  # Match user by email-password pair
  def user
    user = User.find_by(email: email)
    return user if user && user.authenticate(password)
    # No such user? Our handy error is here
    raise(Exceptions::AuthenticationError, Message.invalid_credentials)
  end
end