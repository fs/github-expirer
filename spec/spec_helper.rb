require 'expirer'
require 'timecop'

RSpec.configure do |config|
  config.before(:each) do
     Timecop.freeze(DateTime.parse('2013-01-01 00:00:00'))
  end

  config.after(:each) do
    Expirer.configuration.reset!
    Timecop.return
  end
end
