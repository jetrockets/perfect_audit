# frozen_string_literal: true

require 'dry-initializer'
require 'http'

module PerfectAudit
  class AuthToken
    extend Dry::Initializer

    AUTH_PATH = 'https://auth.ocrolus.com/oauth/token'

    option :client_id
    option :client_secret

    def get
      request if expired?

      @token
    end

    def expired?
      @token.nil? || Time.now >= @expires_at
    end

    private

    def request
      response = HTTP.post(AUTH_PATH, json: credentials)

      raise AuthError if response.status.client_error?
      raise ServerError if response.status.server_error?

      parse(response)
    end

    def credentials
      {
        client_id: client_id,
        client_secret: client_secret,
        grant_type: 'client_credentials',
        audience: 'https://api.ocrolus.com/'
      }
    end

    def parse(response)
      response = JSON.parse(response)

      @token = response['access_token']
      @expires_at = Time.now + response['expires_in']
    end
  end
end
