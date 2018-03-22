require 'spec_helper'

describe PerfectAudit do
  it 'has a version number' do
    expect(PerfectAudit::VERSION).not_to be nil
  end
end

describe 'PerfectAudit#container' do
  it { expect(PerfectAudit.container.keys).to have(2).items }

  it 'should contain `connection` key' do
    expect(PerfectAudit.container.resolve('connection')).to be
  end

  it '`connection` should be an instance of PerfectAudit::Connection' do
    expect(PerfectAudit.container.resolve('connection')).to be_an_instance_of(PerfectAudit::Connection)
  end

  it 'should contain `response_parser` key' do
    expect(PerfectAudit.container.resolve('response_parser')).to be
  end
end
