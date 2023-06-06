# frozen_string_literal: true

require 'spec_helper'

# rubocop:disable RSpec/FilePath
describe PerfectAudit::Connection do
  subject { described_class.new(client_id: 'client_id', client_secret: 'client_secret') }

  before do
    stub_request(:post, /auth/).to_return(auth_response)
  end

  describe '#get' do
    let(:get) { subject.get('books', params: { page: 1 }) }

    before do
      stub_request(:get, /v1/).to_return({ status: 200, body: json(:books) })
    end

    context 'when an auth token can be requested' do
      let(:auth_response) { { status: 200, body: json(:auth_token) } }

      it 'makes a get request' do
        get

        expect(
          a_request(:get, 'https://api.ocrolus.com/v1/books?page=1').
          with(headers: { 'Authorization' => 'Bearer access_token' })
        ). to have_been_made.once
      end
    end

    context 'when an auth token can not be requested' do
      let(:auth_response) { { status: 401, body: json(:access_denied) } }

      it 'raises PerfectAudit::AuthError' do
        expect { get }.to raise_error(PerfectAudit::AuthError)
      end
    end
  end

  describe '#post' do
    let(:post) { subject.post('books/add', params: { name: 'name' }) }

    before do
      stub_request(:post, /v1/).to_return({ status: 200, body: json(:books) })
    end

    context 'when an auth token can be requested' do
      let(:auth_response) { { status: 200, body: json(:auth_token) } }

      it 'makes a post request' do
        post

        expect(
          a_request(:post, 'https://api.ocrolus.com/v1/books/add?name=name').
          with(headers: { 'Authorization' => 'Bearer access_token' })
        ). to have_been_made.once
      end
    end

    context 'when an auth token can not be requested' do
      let(:auth_response) { { status: 401, body: json(:access_denied) } }

      it 'raises PerfectAudit::AuthError' do
        expect { post }.to raise_error(PerfectAudit::AuthError)
      end
    end
  end
end
