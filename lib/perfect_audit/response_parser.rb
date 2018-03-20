require 'ostruct'

module PerfectAudit
  class ResponseParser
    def self.parse(response)
      struct = OpenStruct.new(JSON.parse(response))

      raise StandardError, struct.message if struct.status != 200

      case struct.response
      when Hash
        struct.response.inject({}){|memo,(k,v)| memo[k.to_sym] = v; memo}
      when Array
        struct.response.map do |item|
          item.inject({}){ |memo,(k,v)| memo[k.to_sym] = v; memo }
        end
      else
        struct.response
      end
    end
  end
end
