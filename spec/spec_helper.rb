require 'rspec/collection_matchers'
require 'webmock/rspec'
require 'factory_bot'

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

PerfectAudit.configure do |config|
  config.api_key = 'api_key'
  config.api_secret = 'api_secret'
end
