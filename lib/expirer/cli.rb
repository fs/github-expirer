require 'thor'

module Expirer
  class CLI < Thor
    option 'username', required: true
    option 'password', required: true
    option 'organization', type: :string
    option 'private-only', type: :boolean
    option 'expire-date', type: :string
    option 'config', type: :string

    desc 'list', 'List expired repositories'
    long_desc <<-LONGDESC
      In case two-factor authentication enabled please use your
      Personal Access Tokens instead of your regular password.

      You can generate it using this URL https://github.com/blog/1509-personal-api-tokens
    LONGDESC

    def list
      Expirer.configuration.load_from_file!(options[:file])
      Expirer.configuration.load_from_options!(options.to_hash)

      Expirer::List.with_expired do |repository|
        puts Expirer::Reporter.report(repository)
      end
    end

    default_task :list
  end
end
