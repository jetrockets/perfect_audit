require 'perfect_audit/api/bank_account'

module PerfectAudit
  class Book
    extend Dry::Initializer

    option :pk, optional: true
    option :created, optional: true, as: :created_at
    option :name
    option :is_public, default: proc { false }, as: :public
    option :owner_email, optional: true
    option :status_tags, optional: true
    option :bank_accounts, optional: true, as: :_bank_accounts
    option :docs, optional: true

    alias_method :public?, :public

    def bank_accounts
      _bank_accounts.map do |id, params|
        PerfectAudit::BankAccount.new(params.inject({}){|memo,(k,v)| memo[k.to_sym] = v; memo})
      end
    end
  end
end



