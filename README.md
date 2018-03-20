# PerfectAudit

Perfect Audit API gem.
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
    config[:api_key] = 'your_api_key'
    config[:api_secret] = 'your_api_secret'
  end
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

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/perfect_audit.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

