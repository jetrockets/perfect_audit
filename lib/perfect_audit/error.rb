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
end
