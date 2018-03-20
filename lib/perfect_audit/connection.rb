require 'dry-initializer'
require 'http'

module PerfectAudit
  class Connection
    extend Dry::Initializer

    BASE_PATH = 'https://www.perfectaudit.com/api/v1/'.freeze

    option :api_key
    option :api_secret

    def post(path, parameters)
      HTTP.basic_auth(:user => api_key, :pass => api_secret).post(url(path), parameters)
    end

    def get(path, parameters)
      HTTP.basic_auth(:user => api_key, :pass => api_secret).get(url(path), parameters)
    end


    private

    def url(path)
      URI.join(BASE_PATH, path)
    end
  end
end
