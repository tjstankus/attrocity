Notes
=====

Current
-------


Inventory
---------


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


Attribute declaration API
-------------------------

```ruby
# TODO:
# - default option
# - from (mapping) option

attribute :age, coercer: :integer
```


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


Validation
----------

Can we just offload validation to custom coercers? Maybe.


Documentation
-------------

Initialization with a hash is probably required.


Defaults
--------

How to handle defaults because `Integer(nil)` raises an error

Probably handle defaults at attribute level. Based on default property of an
attribute instance, it will handle coercion errors accordingly. Does this affect
validation?

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

Comes with a default set of coercers.

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

