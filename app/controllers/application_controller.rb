class ApplicationController < ActionController::API
  include Response
  include Exceptions

  before_action :authorize_request
  attr_reader :current_user

  private

  def authorize_request
    # Here we must get user or error
    @current_user = (AuthorizeAPIRequest.new(request.headers).call)[:user]
  end
end
