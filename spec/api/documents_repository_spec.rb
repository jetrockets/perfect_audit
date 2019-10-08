require 'spec_helper'
require 'dry/container/stub'

describe PerfectAudit::DocumentsRepository do
  subject(:documents) do
    PerfectAudit.documents
  end

  let(:connection) { PerfectAudit.container['connection'] }

  describe '#create' do
    let(:id) { Faker::Number.number(5) }
    let(:file) { File.open('spec/support/dummy.pdf') }
    let(:correct_params) {[
      PerfectAudit::DocumentsRepository::CREATE_PATH,
      {
        form: {
          pk: id,
          upload: HTTP::FormData::File.new(file)
        }
      }
    ]}

    before(:each) {
      stub_request(:post, /ocrolus/).to_return(body: json(:success_body), status: 200)
    }

    it { expect(documents).to respond_to(:create) }

    # it 'should call connection#post with correct params' do
    #   expect(connection).to receive(:post).with(*correct_params).and_call_original
    #   documents.create(id, file)
    # end

    it 'should return `true`' do
      expect(documents.create(id, file)).to be(true)
    end
  end
end
