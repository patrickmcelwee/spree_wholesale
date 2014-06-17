# Configure Rails Envinronment
ENV["RAILS_ENV"] = "test"

env = File.expand_path("../dummy/config/environment.rb",  __FILE__)
if File.exists?(env)
  require env
else
  raise LoadError, "Please create the dummy app before running tests. Try running `bundle exec rake test_app`"
end

require 'rails/test_help'
require 'shoulda'
require 'factory_girl'
require 'capybara/rails'

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

include HelperMethods

ActionMailer::Base.delivery_method    = :test
ActionMailer::Base.perform_deliveries = false
ActionMailer::Base.default_url_options[:host] = "example.com"

Rails.backtrace_cleaner.remove_silencers!

class ActionController::TestCase
  include Devise::TestHelpers
end

# Default to US
Spree::Config.set(:default_country_id => 214)
FactoryGirl.reload
