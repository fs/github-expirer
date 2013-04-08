# Github

A quick hack to produce a list of not used repositories at Github.

## Usage

* `script/bootstrap`
* Twik credentials and settings in the `config/config.yml`
* If you are going to browse repositories for an organization
  and/or private repositories set the `organization` and `private_only` params accordingly.
* If you need to search some other interval than 1 year specify that
  in [Chronic](https://github.com/mojombo/chronic) format as an `expire_date` key
* Run `ruby -Ilib bin/expirer`
