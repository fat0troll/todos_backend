class UsersController < ApplicationController
  # Avoid authentication loop
  skip_before_action :authorize_request, only: :create

  def create
    user = User.create!(user_params)
    # We already failed at this point if something went wrong
    auth_token = AuthenticateUser.new(user.email, user.password).call
    response = { message: Message.account_created, auth_token: auth_token }
    json_response(response, :created)
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end
