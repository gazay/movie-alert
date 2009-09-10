require 'rubygems'
# dependencies
gem 'haml'
gem 'sinatra'
gem 'mongodb-mongo'
gem 'mongodb-mongo_ext'
gem 'chriseppstein-compass'
gem 'ericam-compass-susy-plugin'

require 'application'
run Sinatra::Application