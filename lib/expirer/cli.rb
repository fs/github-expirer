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

    def list
      Expirer.configuration.load_from_file!(options[:file])
      Expirer.configuration.load_from_options!(options)

      Expirer::List.with_expired do |repository|
        Expirer::Reporter.report(repository)
      end
    end

    default_task :list
  end
end
