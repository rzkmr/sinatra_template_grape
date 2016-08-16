
ENV['RACK_ENV'] ||= 'development'

require 'rubygems'
require 'bundler'

#load all gems
Bundler.setup
Bundler.require(:default, ENV['RACK_ENV'].to_sym)

# App root configure for everyone else
ROOT_PATH = File.expand_path("../", __FILE__)
configure do
  set :root, ROOT_PATH
end

$LOAD_PATH.unshift("#{ROOT_PATH}/lib", "#{ROOT_PATH}/app")

# require File.join(ROOT_PATH, "config", "")

%w{config/initializers lib app}.each do |dir|
  Dir["#{File.dirname(__FILE__)}/#{dir}/**/*.rb"].each { |f| require(f) }
end
