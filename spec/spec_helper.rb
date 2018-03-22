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

API_KEY = 'api_key'.freeze
API_SECRET = 'api_secret'.freeze

PerfectAudit.configure do |config|
  config.api_key = API_KEY
  config.api_secret = API_SECRET
end
