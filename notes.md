Notes
=====

Design inspiration
------------------

- Virtus
- attrio
  http://igor-alexandrov.github.io/blog/2013/05/23/attrio-typed-attributes-for-ruby-objects/


Tasks
-----

- [ ] Try simplest idea (Virtus style)

- [ ] Go read on DSLs and gather ideas


Ideas
-----

I like the idea of attribute "templates" for lack of a better word, which are
probably just classes. For example, a string attribute (perhaps
Attrocity::Attribute::String) would supply defaults (coercion, etc.). The only
things that would need to be plugged in would be the name. Two values, the raw
value (stored) and the coerced value (output).

In terms of a declarative API, I do like Virtus's interface, but I'm leaning
toward something less type-specific. Something like:

```ruby
# Virtus-style
class MyClass
  include Attrocity # might have a variant like Attrocity.model

  attribute :name, :string
end

module MyModule
  include Attrocity # might have a variant like Attrocity.model

  attribute :height, :integer
end
```

On initialize, attributes are collected into an instance-scope AttributeSet.
When an instance of this class is extended, e.g., `my_class.extend(MyModule)`,
the attribute set of the instance gets the attributes of the module. This is
very much like Virtus, only we're working with instances. We might also work
with classes, but definitely instances, which allows us to do DCI-style dynamic
role/behavior extensions.

- [ ] Would this API work for custom attribute types.

Though the declarative attributes API cannot supply or reference a value, it
could be the case that when an attribute is instantiated it gets a name and a
value.

Each attribute has as collaborators: coercer, mapper?, validator?

Initialization with a hash is probably required.

Instance-scope attribute set, but attributes are declared at class-scope.
Perhaps "bare" or in a block, e.g.:

```ruby
attributes do
  attribute :name, :string
end
```

I think it's okay to assume a hash on initialization, but not assume anything
about the internals of the hash, e.g., values are strings.

Lightweight indifferent access to hash? If possible avoid active_support
inclusion - ends up causing gem version errors in clients.

Prefer include over inheritance

### Other DSL ideas

```ruby
Attributes.define do
  attribute :name, :string
end
```

### Defaults

How to handle defaults because `Integer(nil)` raises an error

Ideas for how to handle defaults?
- App configures built-in Attribute::Integer to default to a number like 0
- Declaratively override the default, which takes precedence over config
- Use your own Attribute object
- Leave it alone and get nil
- How does validation relate to this?

### AttributeSet

- AttributeSet#to_h
- AttributeSet#to_value_object

Value object may be the wrong term. It may be 'immutable' not value. Investigate
ways to generate bare immutable objects in Ruby.
[immutable_struct](https://github.com/iconara/immutable_struct) looks like a
good and not bloated option. It's a bit dated, so might need to be forked.

Lightweight, but not great option:

```ruby
# from attributes hash
Struct.new(*keys).new(*values).freeze
# raises a RuntimeError on mutation
```

Attrocity objets forward #umapped_attributes and #attributes to AttributeSet

### Hooks

Implement Mod.extended(obj) hook such that when the obj.extend(Mod) triggers it,
the obj.attribute_set is merged with Mod.attributes (or Mod.attribute_set)


Coercers
--------

Comes with a default set of coercers.

Additional coercers are added through a registry?

Emphasize custom coercion over types. For example,

```ruby
attribute :publication, :book # looks for a Book coercer
```

Coercers are probably initialized with an attribute. That way they can get
defaults, etc.
