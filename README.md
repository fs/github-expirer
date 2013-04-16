# Github Expirer

A quick hack to produce a list of not used repositories at Github.

## Install

    $ gem install github-expirer

## Usage

    $ github-expirer --username user \
      --password password \
      --organization github-org \
      --private-only true \
      --expire-date "6 months ago"

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
