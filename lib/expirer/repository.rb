require 'github_api'

module Expirer
  class Repository
    def initialize(github_repository)
      @github_repository = github_repository
    end

    def private?
      @github_repository.private
    end

    def pushed_at
      DateTime.parse(@github_repository.pushed_at)
    end

    def url
      @github_repository.html_url
    end

    def expired?
      Checker.expired?(self)
    end
  end
end
