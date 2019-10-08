# PerfectAudit

[![Gem Version](https://badge.fury.io/rb/perfect_audit.svg)](https://badge.fury.io/rb/perfect_audit)
[![Build Status](https://travis-ci.org/jetrockets/perfect_audit.svg?branch=master)](https://travis-ci.org/jetrockets/perfect_audit)
[![Maintainability](https://api.codeclimate.com/v1/badges/f416de8dc8074f1b1588/maintainability)](https://codeclimate.com/github/jetrockets/perfect_audit/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/f416de8dc8074f1b1588/test_coverage)](https://codeclimate.com/github/jetrockets/perfect_audit/test_coverage)

Perfect Audit API wrapper.

[https://ocrolus.com/api-docs/](https://ocrolus.com/api-docs/)

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

For example with invalid credentials you will receive:

``` ruby
PerfectAudit.books.all
#=> PerfectAudit::Error: Email and/or password not found [1306]
```

And if you will try to find a Book that does not exist, you will receive:

``` ruby
PerfectAudit.books.find(82087)
#=> PerfectAudit::Error: Book not found [1401]
```

## Usage

### Books Repository

Get books list for your account

``` ruby
PerfectAudit.books.all
#=> [#<PerfectAudit::Book:0x00007ff51bbfbe28>, ...]
```

Create a book

``` ruby
# Create a book with name=Test
PerfectAudit.books.create('Test')
#=> #<PerfectAudit::Book:0x00007ff51c8e4248 @id=0, @created_at="2018-03-22T20:21:25Z", @name="Test", @public=false ...>

# Create a book with name=Test which is public
PerfectAudit.books.create('Test', true)
#=> #<PerfectAudit::Book:0x00007ff51c8e4248 @id=0, @created_at="2018-03-22T20:21:25Z", @name="Test", @public=true ...>
```

Find book by ID

``` ruby
PerfectAudit.books.find(100)
#=> #<PerfectAudit::Book:0x00007ff51c89f828 @id=100, @created_at="2018-03-22T20:48:54Z", @name="Test", @public=false ...>
```

Delete a book

``` ruby
# To delete a book you can use either its ID or instance
PerfectAudit.books.delete(100)
#=> true

book = PerfectAudit.books.find(100)
PerfectAudit.books.delete(book)
#=> true
```

Export book to Excel
``` ruby
book = PerfectAudit.books.find(100)
File.write('./book.xlsx', PerfectAudit.books.to_excel(book))
```

### Documents Repository

Upload document to a book

``` ruby
# To upload documents to a book you can use book ID or its instance and File
PerfectAudit.documents.create(100, File.open('./document.pdf'))
#=> true

book = PerfectAudit.books.find(100)
PerfectAudit.documents.create(book, File.open('./document.pdf'))
#=> true
```

## Credits

Sponsored by [JetRockets](http://www.jetrockets.pro).

![JetRockets](http://jetrockets.pro/JetRockets.jpg)

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

