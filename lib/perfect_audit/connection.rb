require 'dry-initializer'
require 'http'

module PerfectAudit
  class Connection
    extend Dry::Initializer

    BASE_PATH = 'https://api.ocrolus.com/v1/'.freeze

    option :api_key
    option :api_secret

    def post(path, params = {})
      HTTP.basic_auth(:user => api_key, :pass => api_secret).post(url(path), params)
    end

    def get(path, params = {})
      HTTP.basic_auth(:user => api_key, :pass => api_secret).get(url(path), params)
    end

    private

    def url(path)
      URI.join(BASE_PATH, path)
    end
  end
end
