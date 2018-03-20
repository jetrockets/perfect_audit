require 'dry-initializer'

module PerfectAudit
  class Client
    extend Dry::Initializer

    # include Helpers

    option :api_key#proc { PerfectAudit.api_key }
    option :api_secret#proc { PerfectAudit.api_secret }

    def books
      PerfectAudit::Books.new# self
    end
  end
end
