require 'github_api'

module Expirer
  class Repository
    def initialize(github_repository)
      @github_repository = github_repository
    end

    def private?
      @github_repository.private
    end

    def last_updated_at
      DateTime.parse(last_updated_at_value)
    end

    def url
      @github_repository.html_url
    end

    def expired?
      Checker.expired?(self)
    end

    private

    def last_updated_at_value
      @github_repository.pushed_at || @github_repository.updated_at
    end
  end
end
