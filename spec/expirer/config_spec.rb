require 'spec_helper'

describe Expirer::Config do
  subject(:config) { Expirer::Config.new }

  context 'without configuration file' do
    let(:file) { nil }

    it 'set default values' do
      expect(config.private_only?).to eq(true)
      expect(config.expire_date).to eq(DateTime.parse('2012-01-01 00:00:00'))
    end
  end

  context 'with configuration file' do
    before do
      config.load_from_file!('spec/fixtures/config.yml')
    end

    it 'set values from file' do
      expect(config.username).to eq('user')
      expect(config.password).to eq('password')
      expect(config.organization).to eq('fs')
      expect(config.private_only?).to eq(false)
      expect(config.expire_date).to eq(DateTime.parse('2012-07-01 00:00:00'))
    end
  end

  context 'with command line options' do
    before do
      config.load_from_options!({
        'username' => 'user',
        'password' => 'password',
        'organization' => 'fs',
        'private-only' => false,
        'expire-date' => '6 months ago'
      })
    end

    it 'set values from options' do
      expect(config.username).to eq('user')
      expect(config.password).to eq('password')
      expect(config.organization).to eq('fs')
      expect(config.private_only?).to eq(false)
      expect(config.expire_date).to eq(DateTime.parse('2012-07-01 00:00:00'))
    end
  end
end
