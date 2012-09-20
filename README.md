Github expirer
--------------

A quick hack to produce a list of not used repositories at github.


Usage
-----

* `bundle install`
* Copy `config.yml.example` to `config.yml`
* Edit it and fill in username and password
* If you are going to browse repositories for an organization and/or private repositories set the 'organization' and 'private_only' params accordingly.
* If you need to search some other interval than 1 year specify that in [Chronic](https://github.com/mojombo/chronic) format as an `expire_date` key
* `./expirer.rb`
