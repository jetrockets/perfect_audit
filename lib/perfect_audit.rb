# frozen_string_literal: true

require 'dry-container'
require 'dry-auto_inject'

require 'perfect_audit/auth_token'
require 'perfect_audit/connection'
require 'perfect_audit/error'
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

    def container
      @container ||= Dry::Container.new
    end

    def configuration
      @configuration ||= OpenStruct.new
    end

    private

    def register!
      connection = PerfectAudit::Connection.new(**configuration.to_h)

      container.register :connection, -> { connection }
      container.register :response_parser, -> { PerfectAudit::ResponseParser }
    end
  end

  private

  AutoInject = Dry::AutoInject(container)
end

require 'perfect_audit/api/repositories'
# require 'local_configuration'
