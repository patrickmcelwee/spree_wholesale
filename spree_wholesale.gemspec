# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "spree_wholesale/version"

Gem::Specification.new do |s|
  s.name        = "spree_wholesale"
  s.version     = SpreeWholesale::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Patrick McElwee, Spencer Steffen"]
  s.email       = ["patrick@sewliberated.com"]
  s.homepage    = "https://github.com/patrickmcelwee/spree_wholesale"
  s.summary     = %q{Wholesale accounts for Spree Commerce.}
  s.description = %q{Spree Wholesale adds a wholesale_price field to variants and allows users with a "wholesaler" role to access these prices.}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }

  s.require_paths = ["lib"]

  s.add_dependency('spree_core', '~> 2.1.0')
  s.add_dependency('spree_frontend', '~> 2.1.0')
  s.add_dependency('spree_backend', '~> 2.1.0')
  s.add_dependency('spree_auth_devise', '~> 2.1.0')

  s.add_development_dependency('spree_sample', '~> 2.1.0')
  s.add_development_dependency('shoulda',      '~> 3.0.0')
  s.add_development_dependency('factory_girl', '~> 2.6.0')
  s.add_development_dependency('capybara',     '~> 1.1.2')
  s.add_development_dependency('launchy')
  s.add_development_dependency('sass-rails')
  s.add_development_dependency('sqlite3',      '~> 1.3.4')
end
