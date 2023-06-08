# frozen_string_literal: true

require 'perfect_audit/api/period'

module PerfectAudit
  class BankAccount
    extend Dry::Initializer

    option :pk, as: :id
    option :book_pk, as: :book_id
    option :account_type # , optional: true
    option :account_holder # , optional: true
    option :account_number # , optional: true
    option :holder_zip # , optional: true
    option :holder_state # , optional: true
    option :holder_city # , optional: true
    option :holder_address_1 # , optional: true
    option :holder_address_2 # , optional: true
    option :name
    option :periods, as: :_periods

    def periods
      _periods.map do |item|
        PerfectAudit::Period.new(**item.each_with_object({}) { |(k, v), memo|
                                     memo[k.to_sym] = v
                                   })
      end
    end
  end
end
