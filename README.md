# Cart

Implementation of "Engineering Technical Test 2 (Cart)".

## Installation

This project is packaged as a Ruby gem.  It was developed using the latest
stable ruby (2.3.1) and has no run-time dependencies.  It has development/test
dependencies on [bundler](http://bundler.io/), rake and rspec.  These can be
installed by running `bundle` in the project directory:

    $ bundle


## Usage

There is a spec [spec/scenarios\_spec.rb](spec/scenarios_spec.rb) that tests
whether the implementation generates correct results for the four given
scenarios.  It is part of the test suite that is executed when you run:

    $ rake spec

Or you can run it individually using rspec:

    $ rspec spec/scenarios_spec.rb


## Design notes

This project implements a shopping cart, to which items can be added and items
for billing purposes (with prices) can be retrieved.  There is a basic product
list with prices, but the application of various discounting and bonus rules
means that the items added may not be the same as those billed/delivered (extra
bonus items) and the prices may differ from the standard list.  Promotion codes
are also supported, along with the application of rules to the first month(s)
only.

[lib/cart/shopping\_cart.rb](lib/cart/shopping_cart.rb)

Items added to the cart are coalesced by type, so that if the user adds some of
an item then adds some more of the same, the count of the item is updated.
This is normal behaviour for shopping carts.

Billing items are prepared when `items` or `total` are called.  The cart items
are passed through a series of (pricing rules)[lib/cart/rules] until a matching
rule can generate billing items.  (The last rule is the default -- charge the
item at the listed price.)  The rules implemented are as per the functional
specification:

* Buy some get some free (e.g. the 3 for 2 deal on Unlimited 1GB Sims)
* Bulk discount (e.g. for more than 3 5GB Sims)
* Bonus item (e.g. the 1GB data pack bundled with Unlimited 2GB Sims)

The cart also supports promo codes.  These are set at any point an item is
entered in the cart and checked/applied when the final total is calculated.


### Maintainability

One of the functional spec requirements is that the prices and rules need to be
as flexible as possible to maintain.

Maintenance of *products* (and their prices) and *promo codes* is done via YAML
files in [config/](config).  Note that these files are replicated in
[spec/fixtures](spec/fixtures) so that prices and promos can be maintained
going forwards without breaking the unit tests.

Implementing a rules system is a bit more tricky.  To keep things simple I put
all the rules into a single module
[Cart::Config::Rules](lib/cart/config/rules.rb) that can be mixed in to other
classes.  Putting all the rules in one place -- separate from other application
code -- is probably OK for a first pass, but if this were a production system I
would want a more rigorous approach (e.g. some kind of domain-specific language
or format for defining rules).


### Testing

Development was a matter of designing and building up the system with Rspec
tests for each component.  When enough of the system was in place I created
[the scenarios spec](spec/scenarios_spec.rb) to validate that my implementation
met all four scenarios provided in the functional specification, then I kept
coding until everything worked!


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run
`rake spec` to run the tests. You can also run `bin/console` for an interactive
prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To
release a new version, update the version number in `version.rb`, and then run
`bundle exec rake release`, which will create a git tag for the version, push
git commits and tags, and push the `.gem` file to 
[rubygems.org](https://rubygems.org).
