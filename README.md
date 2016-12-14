# Scoped hash library

It provides scoped view to a hash (mash) data structure.
When the requested scope does not exist, it would fall back to the non-scope key.

```ruby
require 'scoped_hash'
smash = ScopedHash.new( 'tax': { min: 20, max: 40},
    'tax(democratic)': { min: 30, max: 50},
    'tax(republican)': { min: 10, max: 30})

smash.scope('democratic')[:tax][:min] == 30
smash.scope('republican')[:tax][:min] == 10
smash.scope('green')[:tax][:min] == 20
```

The best practice of this library is to create a YAML configuration file with scope annotation, for example the "config.yaml" could be:

```yaml
tax:
  min: 20
  max: 40
  max(green): 60
tax(democratic):
  min: 30
  max: 50
tax(republican):
  min: 10
  max: 30
```

And the scoped access to the configuration could be as following:

```ruby
require 'yaml'
require 'scoped_hash'

config = ScopedHash.new(YAML.load_file('config.yml'))

config.scope('democratic')[:tax][:min] == 30
config.scope('republican')[:tax][:min] == 10
config.scope('green')[:tax][:min] == 20

config[:tax][:max] == 40
config.scope('green')[:tax][:max] == 60
```

## Installation

Simply use gem to install this library:

    gem install scoped_hash

