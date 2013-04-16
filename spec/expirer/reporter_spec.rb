# encoding: utf-8

require 'spec_helper'

describe Expirer::Reporter do
  let(:repository) do
    double(Expirer::Repository,
      pushed_at: double(strftime: 'datetime'),
      url: 'url'
    )
  end

  subject(:report) { Expirer::Reporter.report(repository) }

  context 'when private' do
    before do
      repository.stub(:private?) { true }
    end

    it 'report' do
      expect(report).to eq("datetime: \e[31murl\e[0m")
    end
  end

  context 'when public' do
    before do
      repository.stub(:private?) { false }
    end

    it 'report' do
      expect(report).to eq("datetime: \e[34murl\e[0m")
    end
  end
end
