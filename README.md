# OmniAuth Cronofy OAuth2 Strategy

Strategy to authenticate with Cronofy via OAuth2 in OmniAuth. Contains strategies for both *End User* authorization and *Service Account* authorization.

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

## End User Authorization

### Usage

Here's an example for adding the middleware to a Rails app in `config/initializers/omniauth.rb`:

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do

  provider :cronofy, ENV["CRONOFY_CLIENT_ID"], ENV["CRONOFY_CLIENT_SECRET"], {
    scope: "read_account list_calendars create_event"
  }

end
```

Then to auth with Cronofy you would navigate to `/auth/cronofy`.

### Configuration

Configurable options

* `scope`: A space-separated list of permissions you want to request for the end-user. See the [API Authorization documentation](http://www.cronofy.com/developers/api#authorization) for a full list of available permissions.


### Auth Hash

```ruby
  {
    :provider => "cronofy",
    :uid => "acc_382374827234",
    :info => {
      :email => "jo@company.com",
      :name => "Jo Smith"
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
        :email => "jo@company.com",
        :name => "Jo Smith"
      }
    }
  }
```


## Service Account Authorization

### Usage

Service Accounts allow you to use one set of credentials to access an entire organizations calendar service. This works with Google Apps, Office 365 and Exchange.

This can be used alongside standard end-user auth.

Typical configuration.

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do

  provider :cronofy_service_account, ENV["CRONOFY_CLIENT_ID"], ENV["CRONOFY_CLIENT_SECRET"], {
    scope: "service_account/manage_accounts",
    delegated_scope: "read_account read_events create_event delete_event"
  }

end
```

Then to auth with Cronofy you would navigate to `/auth/cronofy_service_account`.

More information in Service Accounts documentation (link to follow).

### Configuration

Configurable options

* `scope`: A space-separated list of permissions you want to request for the service account. Doc link to follow.

* `delegated_scope` : A space-separated list of permissions you wish to request on the end-user accounts controlled by the Service Account. See the [API Authorization documentation](http://www.cronofy.com/developers/api#authorization) for a full list of available permissions.

### Auth Hash

```ruby
  {
    :provider => "cronofy_service_account",
    :uid => "ser_382374827234",
    :info => {
      :domain => "company.com"
    },
    :credentials => {
      :token => "token",
      :refresh_token => "another_token",
      :expires_at => 1424884727,
      :expires => true
    },
    :extra => {
      :raw_info => {
        :sub = "ser_9324872847",
        :cronofy.service_account.domain => "company.com",
        :cronofy.type => "service_account"
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
