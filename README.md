[![Gem Version](https://badge.fury.io/rb/followability.svg)](https://badge.fury.io/rb/followability)
![test](https://github.com/nejdetkadir/followability/actions/workflows/test.yml/badge.svg?branch=main)
![rubocop](https://github.com/nejdetkadir/followability/actions/workflows/rubocop.yml/badge.svg?branch=main)
[![Ruby Style Guide](https://img.shields.io/badge/code_style-rubocop-brightgreen.svg)](https://github.com/rubocop/rubocop)
![Ruby Version](https://img.shields.io/badge/ruby_version->=_2.7.0-blue.svg)

# Followability
Implements the social network followable functionality for your Active Record models

## Installation
```ruby
gem 'followability', github: 'nejdetkadir/followability', branch: 'main'
```

Install the gem and add to the application's Gemfile by executing:

    $ bundle add followability

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install followability

Run the generator:

    $ rails g followability:install

## Usage
Simply drop in `followability` to a model:

```ruby
class User < ActiveRecord::Base
  followability
end
```

Now, instances of `User` have followability.
```ruby
User.followability?
# => true
```

### Following actions
Avaiable methods:
- decline_follow_request_of
- remove_follow_request_for
- send_follow_request_to
- following?
- mutual_following_with?
- sent_follow_request_to?
- follow_request_sent_by?

### Usage
```ruby
@foo = User.first
@bar = User.last

@foo.send_follow_request_to(@bar)
# => true

@foo.sent_follow_request_to?(@bar)
# => true

@bar.follow_request_sent_by(@foo)
# => true

@bar.decline_follow_request_of(@foo)
# => true

@foo.remove_follow_request_for(@bar)
# => false

@foo.mutual_following_with?(@bar)
# => false

@bar.following?(@foo)
# => false
```

### Blocking actions
Avaiable methods:
- block_to
- unblock_to
- blocked?
- blocked_by?

### Usage
```ruby
@foo.block_to(@bar)
# => true

@foo.blocked?(@bar)
# => true

@bar.blocked_by?(@foo)
# => true

@foo.unblock_to(@bar)
# => true
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/nejdetkadir/followability. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/nejdetkadir/followability/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](LICENSE).

## Code of Conduct

Everyone interacting in the Followability project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/nejdetkadir/followability/blob/main/CODE_OF_CONDUCT.md).
