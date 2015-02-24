Notes
=====

TODO
----

- Convert all specs to require spec_helper

- Attribute should have a method for setting its own value that take the
  arguments that attribute set uses to do the job. ???

- [ ] ? Should attrocity_spec specs be moved to something like module builder
  spec?

- [ ] ? Re-evaluate attrocity_spec. There are some oddities. It seems like it's
  been a default place to put spec code that we weren't sure about the eventual
  home for.

Attribute set cloning
---------------------

Consider making attributes that are attached to a class, that basically act as
templates for instance attributes, to be a different kind of thing so that we're
not cloning, per se, but creating an instance variant of the class attribute
variant on the fly. So, factory approach vs. cloning approach.

Inventory
---------

### Default values

For now, let's just implement the simple version of default values. Will need to
think through best implementation. Guessing some here... the simplest
implementation is to pass an option to Attribute.new and have the attribute
handle default values. DO NOT put this responsibility into the coercer. Coercers
must be kept simple.

How to handle defaults because `Integer(nil)` raises an error

Probably handle defaults at attribute level. Based on default property of an
attribute instance, it will handle coercion errors accordingly. Does this affect
validation?

Default values should not be conflated with coercers. However, when analyzing a
default value, we might want to check that it does not get transformed when
coerced. In other words, with an integer coercer and a default value of 1,
Integer(1) does not change the value, but a default value of '1' would be
considered incorrect and we could catch that by coercing and comparing.

It should be possible to have a nil value, but I don't like the idea of nil
being the fallback value. A string coerced attribute should probably default to
''. Not sure what an integer coerced attribute should default to. Maybe nil as
fallback is the only consistent way to do this.

### Validation?


Design inspiration
------------------

- Virtus
- attrio
  http://igor-alexandrov.github.io/blog/2013/05/23/attrio-typed-attributes-for-ruby-objects/


Concepts
--------

- Coercing: Converting attribute data to the desired type

- Mapping: Getting attribute data from a known hash key that differs from the
  attribute name


Ideas
-----

Lazy forwarding to attribute_set (using method_missing or similar) will allow us
to modify the attribute set on an object instance without having to muck around
with undefining methods and such. For an attribute named :age, we want to allow
for methods: age, age=, [:age], age?. We want to be able to add and remove
attributes and the object should just work without a bunch of metaprogramming on
our part.

On initialize, attributes are collected into an instance-scope AttributeSet.
When an instance of this class is extended, e.g., `my_class.extend(MyModule)`,
the attribute set of the instance gets the attributes of the module. This is
very much like Virtus, only we're working with instances. We might also work
with classes, but definitely instances, which allows us to do DCI-style dynamic
role/behavior extensions.


Documentation
-------------

Initialization with a hash is required.

### AttributeSet

- AttributeSet#to_h
- AttributeSet#to_value_object. Should attribute_set be the thing that handles
  handing back a value object.

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

Attrocity objects forward #umapped_attributes and #attributes to AttributeSet

### Hooks

Implement Mod.extended(obj) hook such that when the obj.extend(Mod) triggers it,
the obj.attribute_set is merged with Mod.attributes (or Mod.attribute_set)

Coercers
--------

Comes with a built-in set of coercers.

Additional coercers are added through a registry.

The library emphasizes custom coercion over types. For example,

```ruby
attribute :publication, :book # looks for a Book coercer
```

Should coercers be initialized with an attribute? That way they can get
defaults, etc.

I don't think the cost of inheritance is worth the enforcement of implementing a
simple API. Let's just define what coercers are and document it.

The coercion API is defined as: an instance method called coerce. Why an
instance method? Because it's more accommodating to future changes.

Documentation for README
------------------------

Attribute values are set and retrieved through their containing AttributeSet.
The Attribute set acts as an aggregate root (in DDD parlance).

