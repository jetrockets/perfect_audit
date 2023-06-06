# frozen_string_literal: true

require 'rspec/collection_matchers'
require 'webmock/rspec'
require 'factory_bot'
require 'faker'

require 'simplecov'
SimpleCov.start

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'perfect_audit'

require 'factory_bot/json_strategy'

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.include FactoryBot::Syntax::Methods

  config.before(:suite) do
    FactoryBot.definition_file_paths = ['spec/factory_bot/factories']
    FactoryBot.find_definitions
    FactoryBot.register_strategy(:json, JsonStrategy)
  end
end

CLIENT_ID = 'client_id'
CLIENT_SECRET = 'client_secret'

PerfectAudit.configure do |config|
  config.client_id = CLIENT_ID
  config.client_secret = CLIENT_SECRET
end
