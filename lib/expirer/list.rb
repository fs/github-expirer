module Expirer
  class List
    # delegate :private_only?, :username, :password, :organization,
    #   to: Expirer.configuration

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
      repositories.select { |repository| repository.expired? }
    end

    def include?(repository)
      return true unless Expirer.configuration.private_only?
      repository.private?
    end

    def github
      @github ||= Github.new(basic_auth: "#{Expirer.configuration.username}:#{Expirer.configuration.password}")
    end

    def repositories
      @repositories ||= github.repos.all(org: Expirer.configuration.organization, per_page: 10_000)
    end
  end
end
