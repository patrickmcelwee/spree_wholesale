Dummy::Application.routes.draw do
  # Mount Spree's routes
  mount Spree::Core::Engine, :at => '/'
end
