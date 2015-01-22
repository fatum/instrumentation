# Instrumentation

That gem add simple sugar for ActiveSupport::Notifications

Subscribe to notifications

```ruby
require 'instrumentation'

class UserNotifier
  include Instrumentation

  subscribe_to 'user.update'

  def self.call(*event)
    say "Processing..."
  end
end
```

If you use Instrumentation by ActiveRecord model you can instrument model's changes and create one subscriber to all produced events

```ruby
require 'Instrumentation'

class User < ActiveRecord::Base
  include Instrumentation

  instrument_to 'models.mutations'
end

class ModelsMutationsSubscriber
  include Instrumentation

  subscribe_to(/models.*/)

  def self.call(channel, _, _, _, payload)
  end
end
```

## Installation

Add this line to your application's Gemfile:

    gem 'instrumentation'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install instrumentation

## Usage

TODO: Write usage instructions here

## Contributing

1. Fork it ( https://github.com/[my-github-username]/instrumentation/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
