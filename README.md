[![Build Status](https://travis-ci.org/patrickmcelwee/spree_wholesale.svg?branch=master)](https://travis-ci.org/patrickmcelwee/spree_wholesale)

Spree wholesale is a simple wholesale solution for Spree Commerce. Spree wholesale adds a wholesaler login and signup page as well as an admin to approve and deny applicants. This is a fork from citrus's fantastic original.

This requires Ruby > 2.0, in order to use module prepend.

------------------------------------------------------------------------------
Installation
------------------------------------------------------------------------------


```ruby
# spree 2.2
gem 'spree_wholesale', :git => 'git://github.com/patrickmcelwee/spree_wholesale', :branch => 'master'

# spree 2.1
gem 'spree_wholesale', :git => 'git://github.com/patrickmcelwee/spree_wholesale', :branch => '2-1-stable'

# spree 2.0
gem 'spree_wholesale', :git => 'git://github.com/patrickmcelwee/spree_wholesale', :branch => '2-0-stable'

# spree 1.3
gem 'spree_wholesale', :git => 'git://github.com/patrickmcelwee/spree_wholesale', :branch => '1-3-stable'

# spree 1.2
gem 'spree_wholesale', :git => 'git://github.com/patrickmcelwee/spree_wholesale', :branch => '1-2-stable'

Then install the necessary migrations, db:migrate, and create the wholesale role:

```bash
# spree 0.50.x and above
rails g spree_wholesale:install
rake db:migrate spree_wholesale:create_role


If you'd like to generate sample wholesale prices based on a 66% discount:

```bash
rake spree_wholesale:assume_wholesale_prices
```


------------------------------------------------------------------------------
Testing
------------------------------------------------------------------------------

If you'd like to run tests:

```bash
git clone git://github.com/patrickmcelwee/spree_wholesale.git
cd spree_wholesale
bundle install
bundle exec test_app
bundle exec rake
```


------------------------------------------------------------------------------
Demo
------------------------------------------------------------------------------

If you'd like a demo of spree_wholesale:

```bash
git clone git://github.com/patrickmcelwee/spree_wholesale.git
cd spree_wholesale
bundle install
bundle exec rake test_app
cd test/dummy
rails s
```


------------------------------------------------------------------------------
To Do
------------------------------------------------------------------------------

* Write more/better tests
* Finish i18n implementation
* Fork this README more


------------------------------------------------------------------------------
Known Issues
------------------------------------------------------------------------------

* A user created in the 'user' tab, or an already existing user with an added 'wholesaler' flag will not be able to purchase at wholesale price. They will see the retail and wholesale price, but when added to cart will purchase at retail price. Only accounts created using wholesale interface work properly.
* Deface override for admin_tabs (Adds wholesalers tab to admin interface) isn't targeting hook correctly, and has been set to insert to bottom of the div#store-menu ul instead.


------------------------------------------------------------------------------
Contributors
------------------------------------------------------------------------------

* Patrick McElwee ([@patrickmcelwee](https://github.com/patrickmcelwee)])
* Spencer Steffen ([@citrus](https://github.com/citrus))
* John Hwang      ([@tavon](https://github.com/tavon))
* Cameron Carroll ([@sanarothe](https://github.com/sanarothe))
* Les Cochrane    ([@oldtinroof](https://github.com/oldtinroof))


------------------------------------------------------------------------------
License
------------------------------------------------------------------------------

Copyright (c) 2011 - 2012 Spencer Steffen and Citrus, released under the New BSD License All rights reserved.
