require 'spec_helper'

describe Expirer do
  describe '.configuration' do
    subject(:config) { Expirer.configuration }

    it 'instance of Config' do
      expect(config).to be_an_instance_of(Expirer::Config)
    end

    it 'have options' do
      expect(config.private_only).to eq(true)
    end

    context 'with config file' do
      before do
        config.load_from_file!('spec/fixtures/config.yml')
      end

      it 'load config file' do
        expect(config.private_only).to eq(false)
      end

      it 'reset defaults' do
        expect { config.reset! }.to change { config.private_only }.from(false).to(true)
      end
    end

    context 'with command line options' do
      before do
        config.load_from_options!({
          'private-only' => false
        })
      end

      it 'load options' do
        expect(config.private_only).to eq(false)
      end
    end
  end
end
