---
title: TODO
---

- [ ] Make a decision about and implement mapped attribute rules

Given the attribute declaration:
```ruby
class User
  include Attrocity.model

  attribute :first_name, coercer: :string, from: :firstname
end
```

And the following argument to initialize:
```ruby
User.new({ first_name: 'Homer' })
```

Should the attribute get initialized with user.first_name of Homer? I think it probably should.

It gets a little muddier when there's a default involved, but I like the following prioritization rules:

1. Mapped attribute
2. Default value
3. Unmapped attribute
4. Coercer default return

I think this only applies to the default KeyMapper. It's really about mapping rules. The coercers handle defaults.

--------------------------------------------------------------------------------

- [ ] Compare to Hashie

- [ ] Go through notes.md and edit, update
