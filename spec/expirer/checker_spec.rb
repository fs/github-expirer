require 'spec_helper'

describe Expirer::Checker do
  describe '.expired?' do
    before do
      Expirer.configuration.expire_date = '6 month ago'
    end

    subject { Expirer::Checker.expired?(repository) }

    context 'with expired repo' do
      let(:repository) do
        double(Expirer::Repository,
          pushed_at: Chronic.parse('10 months ago').to_datetime)
      end

      it { should be true }
    end

    context 'with fresh repo' do
      let(:repository) do
        double(Expirer::Repository,
          pushed_at: Chronic.parse('1 month ago').to_datetime)
      end

      it { should be false }
    end
  end
end
