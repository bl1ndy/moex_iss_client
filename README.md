# Moscow Exchange ISS Client

[![Gem Version](https://badge.fury.io/rb/moex_iss_client.svg)](https://badge.fury.io/rb/moex_iss_client)

This Ruby gem provides a convinient way to get non-real-time securities history from MOEX ISS without authentication.

NOT USED for real-time updating of securities quotes and for algorithmic trading.

- [Getting started](#getting-started)
- [Usage](#usage)
- [Changelog](https://github.com/bl1ndy/moex_iss_client/blob/main/CHANGELOG.md)

## Getting started

To install gem, add this line to your application's `Gemfile`:

```
gem 'moex_iss_client'
```

Then install as follows:

```
$ bundle install
```

Or install it directly using `gem`:

```
$ gem install moex_iss_client
```

## Usage

Create an instance of `MoexIssClient::Client`:

```ruby
client = MoexIssClient::Client.new
```

To get security history from ISS, call `#history` on client and provide security ID:

```ruby
history = client.history('MOEX')
```

Method `#history` provides some options for ISS request:

```ruby
:market # default value: 'shares'

# To search for security history in shares market (could be omitted)
history = client.history('MOEX', market: 'shares')

# To search for security history in bonds market
history = client.history('SU24021RMFS6', market: 'bonds')
```

```ruby
:from # default value: 6 days ago, format: 'YYYY-MM-DD'

history = client.history('MOEX', from: '2023-03-01')
```

```ruby
:till # default value: today, format: 'YYYY-MM-DD'

history = client.history('MOEX', till: '2023-03-15')
```

As we get security history, we should provide it to `MoexIssClient::Security` instance:

```ruby
security = MoexIssClient::Security.new(history)
```

Now we can execute some usefull information from history:

```ruby
# Get last close price

security.last_price #> "112.89"

# Get shortname

security.shortname #> "МосБиржа"

# Get security ID

security.sec_id #> "MOEX"

# Get any existing attribute from data sample

security.attribute('tradedate') #> "2023-03-17"
```
