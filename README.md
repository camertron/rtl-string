rtl-string
==========

Easier string manipulation for people who come from LTR backgrounds.

### Usage

Create a new `RtlString` instance with some Arabic text.  Calling `.to_s` will show an LTR representation of the string.  You should read it from left to right, just like you would an English string:

```ruby
arabic_str = [1575, 1605, 32, 98, 108, 97, 114, 103, 32, 1576, 1573, 1590].pack("U*")
RtlString.new(arabic_str).to_s  # => "[alef][meem] blarg [beh][alef - hamza below][dad]"
```

You can also call `.to_rtl_s` on a regular string:

```ruby
arabic_str.to_rtl_s  # => "[alef][meem] blarg [beh][alef - hamza below][dad]"
```

### String Operations

Instances of `RtlString` respond to a few additional string operations, including `delete_at`, `insert`, `[]`, and `size`:

```ruby
str = arabic_str.to_rtl_s
str.delete_at(1)  # => "[meem]"
str.delete_range(1..2)
str.insert([1605].pack("U*"), 1)
str.to_s          # => "[alef][meem][meem] blarg [beh][alef - hamza below][dad]"
str[1]            # => "[meem]
str[1..3]         # => "[meem] b"
str.size          # => 12
str.length        # => 12
```

### Requirements

Depends on the twitter-cldr-rb gem.

### Running Tests

`bundle exec rspec`

### Authors

* Cameron C. Dutro: http://github.com/camertron
