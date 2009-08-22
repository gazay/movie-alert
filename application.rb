#!/usr/bin/env ruby

require 'rubygems'
require 'sinatra'
require 'haml'
require 'mongo'

host = ENV['MONGO_RUBY_DRIVER_HOST'] || 'localhost'
port = ENV['MONGO_RUBY_DRIVER_PORT'] || XGen::Mongo::Driver::Mongo::DEFAULT_PORT
db = XGen::Mongo::Driver::Mongo.new(host, port).db('imdb_data')

get '/' do
  haml :index
end

%w{actor director}.each do |type|
  get "/suggest/#{type}" do
    #TODO
  end
end

get '/movies' do
  #TODO
end
