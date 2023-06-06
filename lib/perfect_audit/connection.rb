# frozen_string_literal: true

require 'dry-initializer'
require 'http'

module PerfectAudit
  class Connection
    extend Dry::Initializer

    BASE_PATH = 'https://api.ocrolus.com/v1/'

    option :client_id
    option :client_secret

    def post(path, params = {})
      HTTP.auth(auth).post(url(path), params)
    end

    def get(path, params = {})
      HTTP.auth(auth).get(url(path), params)
    end

    private

    def auth
      "Bearer #{auth_token.get}"
    end

    def url(path)
      URI.join(BASE_PATH, path)
    end

    def auth_token
      @auth_token ||= AuthToken.new(client_id: client_id, client_secret: client_secret)
    end
  end
end
