# PayU

A lightweight client for PayU's payment system.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'payu'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install payu

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Testing

To run RSpec, you need to set up environment variables for PayU. For that, you need to get necessary secrets for a Sandbox account at http://developers.payu.com/en/overview.html.

After registering your account and creating your test shop, you can then run the tests and add functionality (WRITE THE TESTS).

Add those to your `bash_profile` or any other environment variables manager of your choice.

```
export PAY_U_POS_ID=<POS_ID>
export PAY_U_SECOND_KEY=<SECOND_KEY>
export PAY_U_OAUTH_CLIENT_ID=<CLIENT_ID>
export PAY_U_OAUTH_CLIENT_SECRET=<CLIENT_SECRET>
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/payu.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
