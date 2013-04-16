require 'spec_helper'

describe Expirer::List do
  let(:private_fresh) { double(Expirer::Repository, expired?: false, private?: true, url: 'private_fresh') }
  let(:private_expired) { double(Expirer::Repository, expired?: true, private?: true, url: 'private_expired') }
  let(:public_expired) { double(Expirer::Repository, expired?: true, private?: false, url: 'public_expired') }

  before do
    Expirer::List.any_instance.should_receive(:repositories) {[
      private_fresh, private_expired, public_expired
    ]}
  end

  context 'when private only is set to true' do
    before do
      Expirer.configuration.private_only = true
    end

    it 'iterates on private only' do
      private_fresh.should_not_receive(:url)
      private_expired.should_receive(:url)
      public_expired.should_not_receive(:url)

      Expirer::List.with_expired do |repository|
        expect(repository).to be_expired
        expect(repository).to be_private

        repository.url
      end
    end
  end

  context 'when private only is set to false' do
    before do
      Expirer.configuration.private_only = false
    end

    it 'iterates on all' do
      private_fresh.should_not_receive(:url)
      private_expired.should_receive(:url)
      public_expired.should_receive(:url)

      Expirer::List.with_expired do |repository|
        expect(repository).to be_expired

        repository.url
      end
    end
  end
end
