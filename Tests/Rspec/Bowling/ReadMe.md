Here's a barebones example of how to run tests using a stand-alone version of Rspec using Rails 5.

# Step 1

Create a ```Gemfile``` and paste this

```language-powerbash
source 'https://rubygems.org'
gem 'rspec'
```


# Step 2

Install gem ```rspec```

```language-powerbash
bundle install
```

# Step 3

Install rspec

```language-powerbash
bundle exec rspec --init
```

# Step 4

Create a new rspec document
```language-powerbash
nano mate spec/bowling_spec.rb
```

# Step 5

Run all tests
```language-powerbash
bundle exec rspec
```

or 

```language-powerbash
ruby init.rb
```

# App Goals

1. Create a class that sums the scores of a bowling game
- jfdfd



# Resources

- [Calling execute commands from a Ruby script](http://stackoverflow.com/questions/2232/calling-shell-commands-from-ruby)
