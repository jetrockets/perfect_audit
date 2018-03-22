require 'spec_helper'

describe PerfectAudit do
  it 'has a version number' do
    expect(PerfectAudit::VERSION).not_to be nil
  end
end

describe 'PerfectAudit#container' do
  it { expect(PerfectAudit.container.keys).to have(2).items }
  it { expect(PerfectAudit.container.resolve('connection')).to be }
  it { expect(PerfectAudit.container.resolve('connection')).to be_an_instance_of(PerfectAudit::Connection) }
  it { expect(PerfectAudit.container.resolve('response_parser')).to be }
end
