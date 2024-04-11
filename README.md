# Pundit::Plus

Add some extra features to Pundit.

- Custom exceptions
- Manage required or permitted params from within your policy classes

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add pundit-plus

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install pundit-plus

## Usage

This includes [Pundit](https://github.com/varvet/pundit) and [Pundit Matchers](https://github.com/pundit-community/pundit-matchers).

Follow the instructions for using Pundit and Pundit Matchers.

Include the `Pundit::Plus` module in your policy classes to add extra features to Pundit. For example:

```ruby
class ApplicationPolicy
  include Pundit::Plus
  # this module defines the default exception_from behavior
end

class MyPolicy < ApplicationPolicy
  # Then you can use your own exception classes
  class CustomException < Pundit::NotAuthorizedError
    def initialize(options = {})
      options[:message] ||= "You are not authorized to perform this action."
      super(options)
    end
  end

  def exeception_from(query:)
    if query == :show?
      CustomException
    else
      super
    end
  end

  def initialize(user, record)
    @user = user
    @record = record
  end

  # Return the params for the action but require a special key
  def params_for_update(params)
    params_for(@record, params, :update).tap do |params|
      params.require(:special_key)
    end
  end

  def permitted_attributes
    %i[name other special_key]
  end
end

class SomeController < ApplicationController
  def update
    @some_record.update(params_for_action(@some_record))
  end
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/SOFware/pundit-plus.
