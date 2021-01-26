# Syft Coding Challenge
*by Daniel Twigg*

## Instructions
1. Ensure you have Ruby 2.6.5 installed, there is a .ruby-version file included.
2. Run `bundle install`
3. Run `bundle exec rspec --format=documentation` to run the tests
4. That's it!

## Developer Notes

I started with a Checkout class to meet the interface required to scan items and provide a total:
```ruby
class Checkout
  def initialize(promotional_rules)
    @promotional_rules = promotional_rules
  end
  
  def scan(item)
    # .....
  end
  
  def total
    # .....
  end
end
```

I added the minimum code required for scanning items to add the item to a collection, and for generating a total without any special promotional rules.

Then I created a structure for promotional rules that allows adding rules that apply to the whole basket total, or an individual item. 

I did toy with the idea of allowing a Ruby block to be passed into the `total` method to allow arbitrary rules, but then the user would have to write Ruby blocks so I didn't follow that route.

I have purposely ignored money formatting and currency and just done a simple rounding to 2 decimal places at the end of the `total` method. In a real world application I would use a library such as the `money` gem to take care of proper rounding and currency conversions.