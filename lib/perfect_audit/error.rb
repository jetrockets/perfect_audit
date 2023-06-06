# frozen_string_literal: true

module PerfectAudit
  class Error < StandardError
    attr_reader :code

    def initialize(message, code)
      @code = code
      super(message)
    end

    def to_s
      super + " [#{@code}]"
    end
  end

  class AuthError < StandardError
    def message
      'Your credentials are invalid or have been revoked'
    end
  end

  class ServerError < StandardError
    def message
      'Ocrolus is unavailable. Please try again later.'
    end
  end
end
