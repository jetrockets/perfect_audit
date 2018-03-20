require 'dry-container'
require 'dry-auto_inject'

require 'perfect_audit/connection'
require 'perfect_audit/response_parser'
require 'perfect_audit/client'
require 'perfect_audit/version'

module PerfectAudit

  class << self
    def configure
      configuration = Hash.new
      yield configuration

      connection = PerfectAudit::Connection.new(configuration)
      # container.register :main_component, -> { MainComponent.new }
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
  end

  # def self.try_dry_rb_container
  #   container.resolve(:main_component).hello_world
  # end

  private

  @@container = Dry::Container.new

  AutoInject = Dry::AutoInject(@@container)

  def self.container
    @@container
  end

  # class << self
  #   attr_accessor :api_key, :api_secret

  #   # config/initializers/perfect_audit.rb (for instance)
  #   #
  #   # PerfectAudit.configure do |config|
  #   #   config.api_key = 'api_key'
  #   #   config.api_secret = 'api_secret'
  #   # end
  #   #
  #   # elsewhere
  #   #
  #   # client = PerfectAudit::Client.new

  #   def configure
  #     yield self
  #     true
  #   end
  # end
end

require 'perfect_audit/api/repositories'

require 'local_configuration'
