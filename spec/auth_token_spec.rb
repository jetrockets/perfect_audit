# frozen_string_literal: true

require 'spec_helper'

# rubocop:disable RSpec/FilePath
# rubocop:disable RSpec/PredicateMatcher
describe PerfectAudit::AuthToken do
  subject(:auth_token) { described_class.new(client_id: 'client_id', client_secret: 'client_secret') }

  describe '#get' do
    let(:get) { auth_token.get }

    let(:response) { {status: 200, body: json(:auth_token)} }

    before do
      auth_token.instance_variable_set(:@token, access_token)
      auth_token.instance_variable_set(:@expires_at, expires_at)

      stub_request(:post, /ocrolus/).to_return(response)
    end

    context 'when a token has not yet been requested' do
      let(:access_token) { nil }
      let(:expires_at) { nil }

      it 'requests a new token' do
        expect(get).to eq('access_token')
      end

      it 'sets expires_at' do
        get

        expect(auth_token.expired?).to be_falsey
      end
    end

    context 'when a token has already been requested' do
      let(:access_token) { 'token' }
      let(:expires_at) { Time.now + 3600 }

      it 'returns the token' do
        expect(get).to eq('token')
      end
    end

    context 'when a token has expired' do
      let(:access_token) { 'token' }
      let(:expires_at) { Time.now - 3600 }

      it 'requests a new token' do
        expect(get).to eq('access_token')
      end

      it 'sets expires_at' do
        get

        expect(auth_token.expired?).to be_falsey
      end
    end

    context 'when credentials are invalid' do
      let(:access_token) { nil }
      let(:expires_at) { nil }

      let(:response) { {status: 401, body: json(:access_denied)} }

      it 'raises PerfectAudit::AuthError' do
        expect { get }.to raise_error(PerfectAudit::AuthError)
      end
    end

    context 'when ocrolus is anavailable' do
      let(:access_token) { nil }
      let(:expires_at) { nil }

      let(:response) { {status: 500, body: json(:server_error)} }

      it 'raises PerfectAudit::ServerError' do
        expect { get }.to raise_error(PerfectAudit::ServerError)
      end
    end
  end

  describe '#expired?' do
    let(:expired) { auth_token.expired? }

    before do
      auth_token.instance_variable_set(:@token, access_token)
      auth_token.instance_variable_set(:@expires_at, expires_at)
    end

    context 'when a token has not yet been requested' do
      let(:access_token) { nil }
      let(:expires_at) { nil }

      it 'returns true' do
        expect(expired).to be_truthy
      end
    end

    context 'when a token has not expired' do
      let(:access_token) { 'token' }
      let(:expires_at) { Time.now + 3600 }

      it 'returns false' do
        expect(expired).to be_falsey
      end
    end

    context 'when a token has expired' do
      let(:access_token) { 'token' }
      let(:expires_at) { Time.now - 3600 }

      it 'returns true' do
        expect(expired).to be_truthy
      end
    end
  end
end
# rubocop:enable RSpec/FilePath
# rubocop:enable RSpec/PredicateMatcher
