require 'chronic'

module Expirer
  class Checker
    def self.expired?(repository)
      new(repository).expired?
    end

    def initialize(repository)
      @repository = repository
    end

    def expired?
      @repository.last_updated_at < Expirer.configuration.expire_date
    end
  end
end
