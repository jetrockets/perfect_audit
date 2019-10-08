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

    before(:each) {
      stub_request(:get, /ocrolus/).to_return(body: json(:books, count: books_count), status: 200)
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

    before(:each) {
      stub_request(:get, /ocrolus/).to_return(body: json(:books), status: 200)
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

  describe '#create' do
    let(:name) { Faker::Science.element }
    let(:public) { Faker::Boolean.boolean }
    let(:correct_params) {[
      PerfectAudit::BooksRepository::CREATE_PATH,
      {
        json: {
          name: name,
          is_public: public.to_s
        }
      }
    ]}

    before(:each) {
      stub_request(:post, /ocrolus/).to_return(body: json(:books), status: 200)
    }

    it { expect(books).to respond_to(:create) }

    it 'should call connection#post with correct params' do
      expect(connection).to receive(:post).with(*correct_params).and_call_original
      books.create(name, public)
    end

    it 'should return instance of PerfectAudit::Book' do
      expect(books.create(name, public)).to be_instance_of(PerfectAudit::Book)
    end
  end

  describe '#delete' do
    let(:id) { Faker::Number.number(5) }
    let(:correct_params) {[
      PerfectAudit::BooksRepository::DELETE_PATH,
      {
        json: {
          book_id: id.to_s
        }
      }
    ]}

    before(:each) {
      stub_request(:post, /ocrolus/).to_return(body: json(:success_body), status: 200)
    }

    it { expect(books).to respond_to(:delete) }

    it 'should call connection#post with correct params' do
      expect(connection).to receive(:post).with(*correct_params).and_call_original
      books.delete(id)
    end

    it 'should return `true` if book is allowed to be removed' do
      expect(books.delete(id)).to be(true)
    end
  end
end
