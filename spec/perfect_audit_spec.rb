# frozen_string_literal: true

require 'spec_helper'

describe PerfectAudit do
  it 'has a version number' do
    expect(PerfectAudit::VERSION).not_to be nil
  end

  it { expect(described_class.container.keys).to have(2).items }

  it 'contains `connection` key' do
    expect(described_class.container.resolve('connection')).to be_present
  end

  it '`connection` should be an instance of PerfectAudit::Connection' do
    expect(described_class.container.resolve('connection')).to be_an_instance_of(PerfectAudit::Connection)
  end

  it 'contains `response_parser` key' do
    expect(described_class.container.resolve('response_parser')).to be_present
  end
end
