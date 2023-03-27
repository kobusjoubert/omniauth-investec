# OmniAuth Investec OAuth2 Strategy

Strategy to authenticate with Investec via OAuth2 in OmniAuth.

API documentation: <https://developer.investec.com>

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'omniauth-investec'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install omniauth-investec

## Usage

Here's an example for adding the middleware to a Rails app in `config/initializers/omniauth.rb`:

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :investec, ENV['INVESTEC_KEY'], ENV['INVESTEC_SECRET'], scope: 'balances accounts transactions transfers cards'
end
```

If you use multiple tenants, you can create a custom class which should inherit from the `OmniAuth::Investec::Tenant` abstract class:

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :investec, tenant_provider_class: YourCustomInvestecProvider
end

class YourCustomInvestecProvider < OmniAuth::Investec::Tenant
  def initialize(strategy)
    @tenant = strategy.env['warden'].user.tenant # Find a way to get the tenant.
  end

  def client_id
    @tenant.client_id
  end

  def client_secret
    @tenant.client_secret
  end

  def scope
    'balances accounts transactions transfers cards'
  end
end
```

## Auth Hash

Here's an example of an authentication hash available in the callback by accessing `request.env['omniauth.auth']`:

```ruby
{
  {
    "provider" => "investec",
    "uid" => nil,
    "credentials" => {
      "token" => "abcdefghijklmnopqrstuv",
      "refresh_token" => "abcdefghijklmnopqrstuv",
      "expires_at" => 1679901790,
      "expires" => true
    },
    "extra" => {}
  }
}
```

Note that we don't have a `uid` value or `info` field yet. This can be added when Investec opens up an endpoint to pull in user info.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kobusjoubert/omniauth-investec.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
