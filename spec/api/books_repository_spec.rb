# frozen_string_literal: true

require 'spec_helper'
require 'dry/container/stub'

# rubocop:disable RSpec/FilePath
describe PerfectAudit::BooksRepository do
  subject(:books) do
    PerfectAudit.books
  end

  let(:connection) { PerfectAudit.container['connection'] }

  before do
    stub_request(:post, /auth/).to_return({status: 200, body: json(:auth_token)})
  end

  describe '#all' do
    let(:correct_params) {
      [
        PerfectAudit::BooksRepository::ALL_PATH
      ]
    }

    let(:books_count) { 5 }

    before {
      stub_request(:get, /v1/).to_return(body: json(:books, count: books_count), status: 200)
    }

    it { expect(books).to respond_to(:all) }

    it 'calls connection#get with correct params' do
      allow(connection).to receive(:get).with(*correct_params).and_call_original

      books.all
      expect(connection).to have_received(:get).with(*correct_params)
    end

    it 'returns instance of Array[PerfectAudit::Book] that have correct number of items' do
      expect(books.all).to be_instance_of(Array) and have(books_count).items and all(be_instance_of(PerfectAudit::Book))
    end
  end

  describe '#find' do
    let(:correct_params) {
      [
        PerfectAudit::BooksRepository::FIND_PATH,
        {
          params: {
            pk: '1'
          }
        }
      ]
    }

    before {
      stub_request(:get, /v1/).to_return(body: json(:books), status: 200)
    }

    it { expect(books).to respond_to(:find) }

    it 'calls connection#get with correct params' do
      allow(connection).to receive(:get).with(*correct_params).and_call_original
      books.find(1)

      expect(connection).to have_received(:get).with(*correct_params)
    end

    it 'returns instance of PerfectAudit::Book' do
      expect(books.find(1)).to be_instance_of(PerfectAudit::Book)
    end
  end

  describe '#create' do
    let(:name) { Faker::Science.element }
    let(:public) { Faker::Boolean.boolean }
    let(:correct_params) {
      [
        PerfectAudit::BooksRepository::CREATE_PATH,
        {
          json: {
            name: name,
            is_public: public.to_s
          }
        }
      ]
    }

    before {
      stub_request(:post, /v1/).to_return(body: json(:books), status: 200)
    }

    it { expect(books).to respond_to(:create) }

    it 'calls connection#post with correct params' do
      allow(connection).to receive(:post).with(*correct_params).and_call_original
      books.create(name, public)

      expect(connection).to have_received(:post).with(*correct_params)
    end

    it 'returns instance of PerfectAudit::Book' do
      expect(books.create(name, public)).to be_instance_of(PerfectAudit::Book)
    end
  end

  describe '#delete' do
    let(:id) { Faker::Number.number(digits: 5) }
    let(:correct_params) {
      [
        PerfectAudit::BooksRepository::DELETE_PATH,
        {
          json: {
            book_id: id.to_s
          }
        }
      ]
    }

    before {
      stub_request(:post, /v1/).to_return(body: json(:success_body), status: 200)
    }

    it { expect(books).to respond_to(:delete) }

    it 'calls connection#post with correct params' do
      allow(connection).to receive(:post).with(*correct_params).and_call_original
      books.delete(id)

      expect(connection).to have_received(:post).with(*correct_params)
    end

    it 'returns `true` if book is allowed to be removed' do
      expect(books.delete(id)).to be(true)
    end
  end
end
# rubocop:enable RSpec/FilePath
