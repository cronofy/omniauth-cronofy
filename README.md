# OmniAuth Cronofy OAuth2 Strategy

Strategy to authenticate with Cronofy via OAuth2 in OmniAuth.

Get your API accesss at: http://www.cronofy.com/developers

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'omniauth-cronofy'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install omniauth-cronofy

## Usage

Here's an example for adding the middleware to a Rails app in config/initializers/omniauth.rb:

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do

  provider :cronofy, ENV["CRONOFY_CLIENT_ID"], ENV["CRONOFY_CLIENT_SECRET"], {
    scope: "read_account list_calendars create_event"
  }

end
```

Then to auth with Cronofy you would navigate to `/auth/cronofy`

## Configuration

Configurable options

* `scope`: A space-separated list of permissions you want to request from the user. See the [API Authorization documentation](http://www.cronofy.com/developers/api#authorization) for a full list of available permissions.

```ruby
  {
    :provider => "cronofy",
    :uid => "acc_382374827234",
    :info => {
      :email = "user@company.com"
    },
    :credentials => {
      :token => "token",
      :refresh_token => "another_token",
      :expires_at => 1424884727,
      :expires => true
    },
    :extra => {
      :raw_info => {
        :account_id = "acc_9324872847",
        :email => "adam@cronofy.com"
      }
    }
  }
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/omniauth-cronofy/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
