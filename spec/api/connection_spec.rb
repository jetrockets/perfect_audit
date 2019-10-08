require 'spec_helper'

describe PerfectAudit::Connection do
  subject(:connection) do
    PerfectAudit.container['connection']
  end

  let(:success_body) { json(:success_body) }

  describe '#api_key' do
    it { expect(connection.api_key).to eq API_KEY }
  end

  describe '#api_secret' do
    it { expect(connection.api_secret).to eq API_SECRET }
  end

  describe '#get' do
    before(:each) do
      stub_request(:get, /ocrolus/).to_return(body: success_body, status: 200)
    end

    # it { expect(a_request(:get, "https://www.perfectaudit.com")).to have_been_made }

    it { expect(connection).to respond_to(:get) }

    it "returns an instance of HTTP::Response" do
      expect(connection.get(PerfectAudit::BooksRepository::FIND_PATH)).to be_an_instance_of(HTTP::Response)
    end

    it { expect(connection.get(PerfectAudit::BooksRepository::FIND_PATH).body.to_s).to eq success_body }
  end

  describe '#post' do
    before(:each) do
      stub_request(:post, /ocrolus/).to_return(body: success_body, status: 200)
    end

    it { expect(connection).to respond_to(:post) }

    it "returns an instance of HTTP::Response" do
      expect(connection.post(PerfectAudit::BooksRepository::CREATE_PATH)).to be_an_instance_of(HTTP::Response)
    end

    it { expect(connection.post(PerfectAudit::BooksRepository::CREATE_PATH).body.to_s).to eq success_body }
  end


end
