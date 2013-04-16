require 'expirer/version'
require 'expirer/config'
require 'expirer/repository'
require 'expirer/checker'
require 'expirer/reporter'
require 'expirer/list'
require 'expirer/cli'

module Expirer
  extend self

  def configuration
    @configuration ||= Config.new
  end
end
