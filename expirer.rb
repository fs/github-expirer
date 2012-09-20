#!/usr/bin/env ruby

require 'github_api'
require 'time'
require 'chronic'
require 'yaml'

class Expirer
  def initialize(config)
    @config ||= {}.merge( config )

    @github = Github.new basic_auth: "#{@config["username"]}:#{@config["password"]}"

    @repos = @github.repos.all( org: @config["org"] )

    @expire = @config["expire"] || Chronic.parse('1 year ago')

    @private_only = @config["private"]
  end

  def run
    @repos.reject { |repo| !check_repo(repo) }.map { |repo| repo_data(repo) }
  end

private

  def private_string(is_private)
    is_private ? "private" : "public"
  end

  def check_repo(repo)
    Time.parse( repo.pushed_at ) < @expire && (!@private_only || repo.private)
  end

  def repo_data(repo)
    [ repo.pushed_at, repo.git_url, private_string(repo.private) ]
  end
end

config = YAML.load( File.read('config.yml') )

expirer = Expirer.new( config )
repos = expirer.run

puts repos.sort.map { |x| x.join(" ")}
