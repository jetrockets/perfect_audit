require 'spec_helper'
require 'dry/container/stub'

describe PerfectAudit::BooksRepository do
  subject(:books) do
    PerfectAudit.books
  end

  let(:connection) { PerfectAudit.container['connection'] }

  describe '#all' do
    let(:correct_params) {[
      PerfectAudit::BooksRepository::ALL_PATH,
    ]}

    let(:books_count) { 5 }

    before {
      stub_request(:get, /perfectaudit/).to_return(body: json(:books, count: books_count), status: 200)
    }

    it { expect(books).to respond_to(:all) }

    it 'should call connection#get with correct params' do
      expect(connection).to receive(:get).with(*correct_params).and_call_original
      books.all
    end

    it "should return instance of Array[PerfectAudit::Book] that have correct number of items" do
      expect(books.all).to be_instance_of(Array) and have(books_count).items and all(be_instance_of(PerfectAudit::Book))
    end
  end

  describe '#find' do
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

    it 'should return instance of PerfectAudit::Book' do
      expect(books.find(1)).to be_instance_of(PerfectAudit::Book)
    end
  end
end
