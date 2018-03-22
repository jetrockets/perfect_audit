require 'spec_helper'
require 'dry/container/stub'

describe PerfectAudit::BooksRepository do
  subject(:books) do
    PerfectAudit.books
  end

  let(:book_after_create_body) { json(:book_after_create_body) }
  let(:connection) { PerfectAudit.container['connection'] }

  before do
    # PerfectAudit.configure do |config|
    #   config.api_key = 'api_key'
    #   config.api_secret = 'api_secret'
    # end

    # connection = Class.new do
    #   def get
    #   end
    # end.new

    # PerfectAudit.container.enable_stubs!
    # PerfectAudit.container.stub(:connection, connection)
    # PerfectAudit.container['connection'].stub(:get) {
    #   HTTP::Response.new({
    #     :status  => 200,
    #     :version => "1.1",
    #     :body => json(:success_body)
    #   })
    # }

    stub_request(:get, /perfectaudit/).to_return(body: book_after_create_body, status: 200)
  end

  context '#find' do
    # before { expect(connection).to receive(:get).with(1, anything, /bar/) }
    # before { books.find(1) }
    before {
      expect(connection).to receive(:get).with(PerfectAudit::BooksRepository::FIND_PATH, {params: { pk: '1'}})
    }

    it { expect(books).to respond_to(:find) }

    it 'should call connection#get' do
      # expect(connection).to receive(:get).with(PerfectAudit::BooksRepository::FIND_PATH, 1)
       books.find(1)

      # books.find(1, nil, "barn")
      # it { expect(books).to respond_to(:find) }
    end
  end


  # it 'blah blah' do
  #   expect(
  #     PerfectAudit::BooksRepository.new.find(1)
  #   ).to have(2).items
  # end
end
