require 'ansi/code'

module Expirer
  class Reporter
    def self.report(repository)
      new(repository).report
    end

    def initialize(repository)
      @repository = repository
    end

    def report
      "#{datetime}: #{url}"
    end

    private

    def datetime
      @repository.pushed_at.strftime('%Y %b %e %a %T')
    end

    def url
      if @repository.private?
        ANSI.red { @repository.url }
      else
        ANSI.blue { @repository.url }
      end
    end
  end
end
