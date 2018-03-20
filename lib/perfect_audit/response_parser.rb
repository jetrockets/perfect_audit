require 'ostruct'

module PerfectAudit
  class ResponseParser
    def self.parse(response)
      struct = OpenStruct.new(JSON.parse(response))

      raise StandardError, struct.message if struct.status != 200

      struct
    end
  end
end
