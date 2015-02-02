# Uninclude

[![Gem Version](https://badge.fury.io/rb/uninclude.svg)](http://rubygems.org/gems/uninclude)
[![Build Status](https://travis-ci.org/rosylilly/uninclude.svg?branch=master)](https://travis-ci.org/rosylilly/uninclude)
[![Dependency Status](https://gemnasium.com/rosylilly/uninclude.svg)](https://gemnasium.com/rosylilly/uninclude)

Implement Module#uninclude and Object#unextend

## Tested ruby versions

- 2.1.4
- 2.1.0
- 2.0.0
- 1.9.3
- 1.9.2
- 1.8.7
- REE

see [travis-ci.org](https://travis-ci.org/rosylilly/uninclude)

## Installation

Add this line to your application's Gemfile:

    gem 'uninclude'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install uninclude

## Usage

```ruby
require 'uninclude'

module Bar
end

class Foo
  include Bar
end

p Foo.ancestors # => [Foo, Bar, Object, Kernel, BasicObject]

Foo.class_eval { uninclude Bar }
p Foo.ancestors # => [Foo, Object, Kernel, BasicObject]

foo = Foo.new

foo.extend(Bar)
p foo.singleton_class.ancestors # => [Bar, Foo, Object, Kernel, BasicObject]

foo.unextend(Bar)
p foo.singleton_class.ancestors # => [Foo, Object, Kernel, BasicObject]
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
