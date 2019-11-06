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

First - read the API documentation here: `http://developers.payu.com/en/restapi.html#overview` to get a grip of what this client does.
Configure the library with your PayU Merchant configuration. You can do it like this in `config/initializers/pay_u`:

```
PayU.configure do |c|
  c.pos_id = ENV['PAY_U_POS_ID']
  c.second_key = ENV['PAY_U_SECOND_KEY']
  c.oauth_client_id = ENV['PAY_U_OAUTH_CLIENT_ID']
  c.oauth_client_secret = ENV['PAY_U_OAUTH_CLIENT_SECRET']
  c.env = 'sandbox' # optional, it defaults to 'production'
  c.notify_url = 'https://example.com'
end
```

After that, you are free to use it. The main concern here is the PayU::Client which is accessible throught `PayU.client` method.

Available functionality:

### Placing orders

```
  meta = {
    "customer_ip": "127.0.0.1",
    "description": "RTV market",
    "currency_code": "PLN",
    "total_amount": "15000",
    "ext_order_id":"XEGB34325" # your order's id
  }

  buyer = {
    email: "john.doe@example.com",
    phone: "654111654",
    first_name: "John",
    last_name: "Doe"
  }

  products = [
    {
      name: "Wireless Mouse for Laptop",
      unit_price: "15000",
      quantity: "1"
    }
  ]

  total_amount = "15000"

  response = PayU.client.place_order(buyer, products, total_amount, meta)

  response.success?
  #=> true
  response.order_id
  #=> "WZHF5FFDRJ140731GUEST000P01"
  response.ext_order_id
  #=> "XEGB34325"
  response.redirect_url
  #=> # this will return a redirection url to PayU
```

Which will return a `PayU::Orders::Response` object which wraps up everything from the response.

### Refunding orders

```
  order_id = "WZHF5FFDRJ140731GUEST000P01"
  amount = 15000 # optional

  response = PayU.client.refund_order(order_id, amount = nil)

  response.success?
  #=> true
  response.ext_order_id
  #=> "XEGB34325"
  response.order_id
  #=> "WZHF5FFDRJ140731GUEST000P01"
```

### Canceling Orders

```
  order_id = "WZHF5FFDRJ140731GUEST000P01"

  response = PayU.client.cancel_order(order_id)

  response.success?
  #=> true
  response.ext_order_id
  #=> "XEGB34325"
  response.order_id
  #=> "WZHF5FFDRJ140731GUEST000P01"
```

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
