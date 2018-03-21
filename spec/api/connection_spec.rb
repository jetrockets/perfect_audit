require 'spec_helper'

describe PerfectAudit::Connection do
  let(:api_key) { 'api_key' }
  let(:api_secret) { 'api_secret' }

  subject(:connection) do
    described_class.new(
      :api_key  => api_key,
      :api_secret  => api_secret
    )
  end

  context '#get' do
    before do
      stub_request(:any, /perfectaudit/).to_return(body: json(:success_body), status: 200)
    end

    # it { expect(a_request(:get, "https://www.perfectaudit.com")).to have_been_made }

    # it "includes HTTP::Headers::Mixin" do
    #   expect(connection.get('book/info').body.to_s).to eq json(:success_body)
    # end

    it "returns an instance of HTTP::Response" do
      expect(connection.get(PerfectAudit::BooksRepository::FIND_PATH)).to be_an_instance_of(HTTP::Response)
    end
  end

  context '#post' do
    before do
      stub_request(:any, /perfectaudit/).to_return(body: json(:success_body), status: 200)
    end

    it "returns an instance of HTTP::Response" do
      expect(connection.post(PerfectAudit::BooksRepository::CREATE_PATH, {})).to be_an_instance_of(HTTP::Response)
    end
  end


end
