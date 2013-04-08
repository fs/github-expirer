#!/usr/bin/env ruby

require 'rubygems'
require 'bundler/setup'

require 'active_support/all'
require 'github_api'
require 'time'
require 'chronic'
require 'yaml'

class Hashie::Mash
  def to_s
    [pushed_at, html_url, private ? 'private' : 'public'].join(' ')
  end
end

class Expirer
  attr_accessor :config

  def initialize(config)
    @config = {
      expire_date:  '1 year ago',
      private_only: false,
    }.merge(config.symbolize_keys)
  end

  def expired_repositories
    repositories.select do |repository|
      private?(repository) && expired?(repository)
    end.sort_by(&:pushed_at)
  end

  private

  def expire_date
    @expire_date ||= Chronic.parse(@config[:expire_date])
  end

  def github
    @github ||= Github.new(basic_auth: "#{@config[:username]}:#{@config[:password]}")
  end

  def repositories
    @repositories ||= github.repos.all(org: @config[:organization], per_page: 10000)
  end

  def private?(repository)
    return true unless config[:private_only]
    repository.private
  end

  def expired?(repository)
    Time.parse(repository.pushed_at) < expire_date
  end
end
