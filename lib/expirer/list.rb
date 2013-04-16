require 'active_support/core_ext/module/delegation'

module Expirer
  class List
    delegate :private_only?, :username, :password, :organization,
      to: :configuration

    def self.with_expired(&block)
      new.with_expired(&block)
    end

    def with_expired
      expired(repositories).each do |repository|
        yield(repository) if include?(repository)
      end
    end

    private

    def expired(repositories)
      repositories.select do |repository|
        repository.expired?
      end
    end

    def include?(repository)
      return true unless private_only?
      repository.private?
    end

    def repositories
      @repositories ||= wrap(github_repositories)
    end

    def wrap(repositories)
      repositories.map { |repository| Repository.new(repository) }
    end

    def github_repositories
      @github_repositories ||= github.repos.all(
        org: organization,
        per_page: 10_000
      )
    end

    def github
      @github ||= Github.new(
        login: username,
        password: password
      )
    end

    def configuration
      Expirer.configuration
    end
  end
end
