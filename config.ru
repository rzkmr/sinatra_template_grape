require File.expand_path("../kick.rb", __FILE__)

# Load app
run Rack::Cascade.new [BaseAPI, ApplicationController]

# map the controllers to routes
map('/example') { run ExampleController }

