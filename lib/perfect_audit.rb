require 'dry-container'
require 'dry-auto_inject'

require 'perfect_audit/connection'
require 'perfect_audit/response_parser'
require 'perfect_audit/version'

module PerfectAudit

  class << self
    def configure
      yield configuration

      register!
    end

    def books
      PerfectAudit::BooksRepository.new
    end

    def documents
      PerfectAudit::DocumentsRepository.new
    end

    # def transactions
    #   PerfectAudit::TransactionsRepository.new
    # end

    # private

    def register!
      connection = PerfectAudit::Connection.new(configuration.to_h)

      container.register :connection, -> { connection }
      container.register :response_parser, -> { PerfectAudit::ResponseParser }
      # container.freeze
    end
  end

  private

  @@container = Dry::Container.new

  AutoInject = Dry::AutoInject(@@container)

  def self.container
    @@container
  end

  def self.container=(v)
    @@container = v
  end

  def self.configuration
    @@configuration ||= OpenStruct.new
  end
end

require 'perfect_audit/api/repositories'
# require 'local_configuration'
