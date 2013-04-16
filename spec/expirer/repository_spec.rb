require 'spec_helper'

describe Expirer::Repository do
  subject(:repository) do
    Expirer::Repository.new(double(
      pushed_at: '2011-01-26T19:06:43Z',
      html_url: 'http://github.com/fs/test',
      private: true
    ))
  end

  it 'pushed_at' do
    expect(repository.pushed_at).to be_a_kind_of(DateTime)
    expect(repository.pushed_at).to eq(DateTime.parse('2011-01-26T19:06:43Z'))
  end

  it 'url' do
    expect(repository.url).to eq('http://github.com/fs/test')
  end

  it 'private?' do
    expect(repository).to be_private
  end

  it 'expired?' do
    Expirer::Checker.should_receive(:expired?).with(repository) { true }
    expect(repository).to be_expired
  end
end

