# Notes

## Mappers/Coercers data injection

The crux of the issue is that for mapping or coercing I might want to inject some values, such as null values to compare against. These values differ on a per-attribute basis.

The library calls specific methods with specific arguments. I need to get those args into the library.

It does feel like more of a coercion problem than a mapping problem. I think I originally reached for the mapper because I thought I had more control.

- [ ] ? Via coercer registry?

- [ ] ? Change to the attribute DSL for coercer? Pass hash with args? If not a hash, but simply a symbol, assume it's the name?

- [ ] ? How might we do this with blocks?

## Current refactorings

- [ ] Process pending specs: delete unnecessary, make valid ones pass.

## Handling missing data

I think these are the rules...

It should probably be nil. Perhaps if the mapper returns nil we don't even bother coercing it. There's a concept here and it's around extracting data. Every attribute has a coercer, by rule of API, and every attribute has a mapper, either explicitly declared or the default KeyMapper. When an attribute is missing, in other words when the mapper cannot extract data (returns nil), the default value is applied. The "default" default value is nil. When the default value is applied, no coercion is performed.

ValueExtractor (or a better named class) takes a mapper, a coercer, and a default value, which defaults to nil.

- [ ] Write up some spec/examples and also for the README

## Attributes

### Collaborators

In which collaborator would it most make sense to add in default value behavior?

Mapper: Simply retrieves the data from raw attributes data. `call` it with an object and a hash of data and it returns a value. It might return nil. Potentially, it could accept a default and fallback to that value, but I'm not sure that's within the responsibility of this object.

Coercer: Simply assures the data its passed comes back as the correct type.

Who knows how to assemble/initialize a Mapper? I don't think Attribute needs to
be the keeper of that knowledge. If Mapper's public interface is to receive the
call message with obj, attributes_data, and an optional default value, then a
fully realized mapper should be passed into an Attribute, moving that work
outside of Attribute and simplifying it.

Of the 2 objects, coercer and mapper, if I had to choose between the two to shim
default value behavior, I would choose the mapper.

Do we map a coerced value OR do we coerce a mapped value? I think we coerce a
mapped value. Right. Map, then send the result to the coercer.

Do we map/coerce before handing the value to an InstanceAttribute?

I like the idea of working inside-out here, from the innermost objects outward,
because I think we have the right objects, they're just combined in funky ways.
At this point, it feels right to start with mapper -> coercer -> ?.
(ClassAttribute probably doesn't need any of those data-related collaborators.)

### Coercers

I'm concerned the return value/behavior of coercers is inconsistent. I'm not
sure what to do about it yet, though, other than note it.

Coercers::Integer - It's possible in a couple different ways to raise an error,
so we normalize the different kinds of errors into a single
Attrocity::CoercionError. We are simply using Kernel.Integer for this coercer,
which is the source for raising (at least) a couple different errors: TypeError,
ArgumentError.

Coercers::String: - It doesn't seem possible for this coercer to raise an error
in its current implementation. It uses Kernel.String, which in turn uses to_s,
which is implemented in Object.

Coercers::Boolean - At this point, this is a custom implementation, specific to
RentPath, but I'm thinking that it should default to the Ruby notion of
truthiness. Yes, the default boolean coercer will adhere to the Ruby notion of
truthiness. But we need to then inject a coercer that's not part of the built-in
coercers, which we should probably do in RentalsModels. This work is done.

### ClassAttribute

- [ ] Start with default_value as a simple Ruby attribute (data).

### InstanceAttribute

Start here and work backwards towards ClassAttribute.

---

DefaultValue
NullDefaultValue

Should a default value of nil be supported?

default_value_for

---

clone is confusing

---

Is options a class or a module?

Options attributes are first-class attributes (with coercion, mapping, etc.)

# TODO

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
