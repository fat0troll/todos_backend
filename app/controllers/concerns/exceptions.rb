module Exceptions
  extend ActiveSupport::Concern

  # Inherit token-related errors from standard one
  class AuthenticationError < StandardError; end
  class MissingToken < StandardError; end
  class InvalidToken < StandardError; end

  included do
    rescue_from ActiveRecord::RecordNotFound do |e|
      json_response({ message: e.message }, :not_found)
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      json_response({ message: e.message }, :unprocessable_entity)
    end

    rescue_from Exceptions::AuthenticationError do |e|
      json_response({ message: e.message }, :unauthorized)
    end

    rescue_from Exceptions::MissingToken do |e|
      json_response({ message: e.message }, :unprocessable_entity)
    end

    rescue_from Exceptions::InvalidToken do |e|
      json_response({ message: e.message }, :unprocessable_entity)
    end
  end
end