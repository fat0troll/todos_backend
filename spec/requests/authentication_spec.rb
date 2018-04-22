require 'rails_helper'

RSpec.describe 'Authentication', type: :request do
  describe 'POST /login' do
    let!(:user) { create(:user) }
    let(:headers) { valid_headers.except('Authorization') }
    # Valid login and password
    let(:valid_credentials) do
      {
        email: user.email,
        password: user.password
      }.to_json
    end
    # Random login and password
    let(:invalid_credentials) do
      {
        email: Faker::Internet.email,
        password: Faker::Internet.password
      }.to_json
    end

    # Should return auth token
    context 'When request is valid' do
      before { post '/login', params: valid_credentials, headers: headers }

      it 'returns an authentication token' do
        expect(json['auth_token']).not_to be_nil
      end
    end

    # Should return error
    context 'When request is invalid' do
      before { post '/login', params: invalid_credentials, headers: headers }

      it 'returns a failure message' do
        expect(json['message']).to match(/Invalid credentials/)
      end
    end
  end
end