Attrocity
=========

You should totally be using [Virtus](https://github.com/solnic/virtus) instead.
This gem is a work in progress.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'attrocity'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install attrocity

## Usage

Don't. Not yet.

## Objects

### Mappers

A mapper is responsible for extracting values from source data. A mapper object
responds to `call` and accepts as arguments to call: the instantiated model
object and the source data hash.

The default, built-in mapper is KeyMapper. When no mapper is explicitly
declared, KeyMapper is used. It simply fetches from the source data hash, using
the attribute name as hash key and falling back to nil as default.

### Coercers

Coercers translate mapped data into the correct type. For example, the string
'1' is coerced to the integer 1 if the built-in integer coercer is used.

The built-in coercers are: string, integer, and boolean.

Custom coercers are the primary way of extracting data when the built-in
coercers are not sufficient for the use case.

[ ... more stuff on custom coercers here ... ]

## Contributing

1. Fork it ( https://github.com/[my-github-username]/attrocity/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
