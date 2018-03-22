require 'spec_helper'
require 'dry/container/stub'

describe PerfectAudit::BooksRepository do
  subject(:books) do
    PerfectAudit.books
  end

  # let(:book_create_body) { json(:book_create_body) }
  let(:connection) { PerfectAudit.container['connection'] }

  context '#all' do
    let(:correct_params) {[
      PerfectAudit::BooksRepository::ALL_PATH,
    ]}

    before {
      stub_request(:get, /perfectaudit/).to_return(body: json(:books, count: 5), status: 200)
    }

    it { expect(books).to respond_to(:all) }

    it 'should call connection#get with correct params' do
      expect(connection).to receive(:get).with(*correct_params).and_call_original
      books.all
    end
  end

  context '#find' do
    let(:correct_params) {[
      PerfectAudit::BooksRepository::FIND_PATH,
      {
        params: {
          pk: '1'
        }
      }
    ]}

    before {
      stub_request(:get, /perfectaudit/).to_return(body: json(:books), status: 200)
    }

    it { expect(books).to respond_to(:find) }

    it 'should call connection#get with correct params' do
      expect(connection).to receive(:get).with(*correct_params).and_call_original
      books.find(1)
    end
  end
end
