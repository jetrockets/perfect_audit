# frozen_string_literal: true

require 'spec_helper'
require 'dry/container/stub'

# rubocop:disable RSpec/FilePath
describe PerfectAudit::DocumentsRepository do
  subject(:documents) do
    PerfectAudit.documents
  end

  let(:connection) { PerfectAudit.container['connection'] }

  before do
    stub_request(:post, /auth/).to_return({ status: 200, body: json(:auth_token) })
  end

  describe '#create' do
    let(:id) { Faker::Number.number(digits: 5) }
    let(:file) { File.open('spec/support/dummy.pdf') }
    let(:correct_params) {
      [
        PerfectAudit::DocumentsRepository::CREATE_PATH,
        {
          form: {
            pk: id,
            upload: HTTP::FormData::File.new(file)
          }
        }
      ]
    }

    before {
      stub_request(:post, /v1/).to_return(body: json(:success_body), status: 200)
    }

    it { expect(documents).to respond_to(:create) }

    # it 'should call connection#post with correct params' do
    #   expect(connection).to receive(:post).with(*correct_params).and_call_original
    #   documents.create(id, file)
    # end

    it 'returns `true`' do
      expect(documents.create(id, file)).to be(true)
    end
  end
end
# rubocop:enable RSpec/FilePath
