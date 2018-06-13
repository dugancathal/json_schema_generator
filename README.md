# JsonSchemaGenerator

This gem exists to help generate JSON schemas from pre-existing JSON.
My primary use-case for this is to help with "contract" testing and drift.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'json_schema_generator'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install json_schema_generator

## Usage

The surface area of this gem is _very_ small (one method).
You can generate a *ruby*-based schema for some input JSON like so:

```ruby
JsonSchemaGenerator.generate('{"a": 1}') #=> {"type": "object", ...}
```

## Development

After checking out the repo, run `bundle install` to install dependencies. 
Then, run `rake spec` to run the tests.

To install this gem onto your local machine, run `bundle exec rake install`. 
To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/json_schema_generator. 
This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the JsonSchemaGenerator project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/json_schema_generator/blob/master/CODE_OF_CONDUCT.md).
