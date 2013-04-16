require 'yaml'
require 'active_support/core_ext/hash/keys'
require 'expirer/core_ext/string/underscore_keys'

module Expirer
  class Config
    DEFAULTS = {
      private_only: true,
      expire_date: '1 year ago'
    }.freeze

    OPTIONS = [:username, :password, :organization, :private_only, :expire_date]
    attr_accessor *OPTIONS

    def initialize
      reset!
    end

    def load_from_file!(file)
      set_options(config_from_file(file)) if file && File.exists?(file)
    end

    def reset!
      set_options(DEFAULTS)
    end

    def load_from_options!(options)
      set_options(options.underscore_keys.symbolize_keys)
    end

    def expire_date
      @parsed_expire_date ||= Chronic.parse(@expire_date).to_datetime
    end

    def private_only?
      private_only
    end

    private

    def config_from_file(file)
      @config_from_file ||= YAML.load(File.read(file)).symbolize_keys
    end

    def set_option(key, value)
      self.send("#{key}=", value)
    end

    def with_options
      OPTIONS.each do |key|
        yield(key)
      end
    end

    def set_options(storage)
      with_options do |key|
        set_option(key, storage[key]) if storage.include?(key)
      end
    end
  end
end
