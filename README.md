# PerfectAudit

[![Build Status](https://travis-ci.org/igor-alexandrov/perfect_audit.svg?branch=master)](https://travis-ci.org/igor-alexandrov/perfect_audit)
[![Maintainability](https://api.codeclimate.com/v1/badges/72f40b05552e16b9cd4f/maintainability)](https://codeclimate.com/github/igor-alexandrov/perfect_audit/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/72f40b05552e16b9cd4f/test_coverage)](https://codeclimate.com/github/igor-alexandrov/perfect_audit/test_coverage)

Perfect Audit API wrapper.

[https://www.perfectaudit.com/api_docs](https://www.perfectaudit.com/api_docs)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'perfect_audit'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install perfect_audit

## Configuration

``` ruby
  PerfectAudit.configure do |config|
    config.api_key = 'your_api_key'
    config.api_secret = 'your_api_secret'
  end
```

## Exception Handling

If PerfectAudit will return anything different from 200 OK status code, `PerfectAudit::Error` will be raised. It contains `#message` and `#code` returned from API.

``` ruby
[1] pry(main)> PerfectAudit.books.all
PerfectAudit::Error: Email and/or password not found [1306]
from /Users/igor/workspace/perfect_audit/lib/perfect_audit/response_parser.rb:9:in `parse'
[2] pry(main)>
```

## Usage

### Books

Get books list for your account:

``` ruby
PerfectAudit.books.all
```

Create a book:

``` ruby
PerfectAudit.books.create(name: 'Test book', is_public: 'false')
```

Get book information:

``` ruby
PerfectAudit.books.find(book_id)
```

Delete a book:

``` ruby
PerfectAudit.books.delete(book_or_id)
```

### Documents

Upload document to a book:

``` ruby
PerfectAudit.documents.create(book_or_id, file_or_io)
```

## Credits

Sponsored by [JetRockets](http://www.jetrockets.pro).

![JetRockets](http://jetrockets.pro/JetRockets.jpg)

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

