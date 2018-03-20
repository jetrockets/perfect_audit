require 'dry-container'
require 'dry-auto_inject'

require 'perfect_audit/connection'
require 'perfect_audit/response_parser'
require 'perfect_audit/version'

module PerfectAudit

  class << self
    def configure
      configuration = Hash.new
      yield configuration

      connection = PerfectAudit::Connection.new(configuration)

      container.register :connection, -> { connection }
      container.register :response_parser, -> { PerfectAudit::ResponseParser }
      container.freeze
    end

    def books
      PerfectAudit::BooksRepository.new
    end

    def documents
      PerfectAudit::DocumentsRepository.new
    end

    def transactions
      PerfectAudit::TransactionsRepository.new
    end
  end

  private

  @@container = Dry::Container.new

  AutoInject = Dry::AutoInject(@@container)

  def self.container
    @@container
  end
end

require 'perfect_audit/api/repositories'
# require 'local_configuration'
