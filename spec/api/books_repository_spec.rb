require 'spec_helper'
require 'dry/container/stub'

describe PerfectAudit::BooksRepository do
  before do
    # PerfectAudit.configure do |config|
    #   config.api_key = 'api_key'
    #   config.api_secret = 'api_secret'
    # end

    connection = Class.new do
      def get
      end
    end.new

    # PerfectAudit.container.enable_stubs!
    # PerfectAudit.container.stub(:connection, connection)
    PerfectAudit.container['connection'].stub(:get) {
      HTTP::Response.new({
        :status  => 200,
        :version => "1.1",
        :body => json(:success_body)
      })
    }
  end

  # it 'blah blah' do
  #   expect(
  #     PerfectAudit::BooksRepository.new.find(1)
  #   ).to have(2).items
  # end
end
