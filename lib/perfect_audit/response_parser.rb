# frozen_string_literal: true

require 'ostruct'
require 'perfect_audit/error'

module PerfectAudit
  class ResponseParser
    def self.parse(response)
      struct = OpenStruct.new(JSON.parse(response))

      raise PerfectAudit::Error.new(struct.message, struct.code) if struct.status != 200

      case struct.response
      when Hash
        struct.response.each_with_object({}) { |(k, v), memo|
          memo[k.to_sym] = v
        }
      when Array
        struct.response.map do |item|
          item.each_with_object({}) { |(k, v), memo|
            memo[k.to_sym] = v
          }
        end
      else
        struct.response
      end
    end
  end
end
