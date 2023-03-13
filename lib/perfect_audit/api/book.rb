# frozen_string_literal: true

require 'perfect_audit/api/bank_account'
require 'perfect_audit/api/document'

module PerfectAudit
  class Book
    extend Dry::Initializer

    option :pk, as: :id
    option :created, as: :created_at
    option :name
    option :is_public, as: :public
    option :owner_email, optional: true
    option :status_tags, optional: true
    option :bank_accounts, optional: true, as: :_bank_accounts
    option :docs, optional: true, as: :_documents

    alias_method :public?, :public

    def bank_accounts
      _bank_accounts.map do |id, params|
        PerfectAudit::BankAccount.new(params.each_with_object({}) { |(k, v), memo|
                                        memo[k.to_sym] = v
                                      })
      end
    end

    def documents
      _documents.map do |item|
        PerfectAudit::Document.new(item.each_with_object({}) { |(k, v), memo|
                                     memo[k.to_sym] = v
                                   })
      end
    end

    def verification_complete?
      documents.all?(&:verification_complete?)
    end

    def verification_failed?
      documents.any?(&:failed?)
    end

    def verification_rejected?
      documents.any?(&:rejected?)
    end
  end
end
