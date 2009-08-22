#!/usr/bin/env ruby

require 'rubygems'
require 'sinatra'
require 'haml'
require 'mongo'

HOST = ENV['MONGO_RUBY_DRIVER_HOST'] || 'localhost'
POST = ENV['MONGO_RUBY_DRIVER_PORT'] || XGen::Mongo::Driver::Mongo::DEFAULT_PORT
DB     = XGen::Mongo::Driver::Mongo.new(HOST, POST).db('imdb_data')
MOVIES = DB.collection('movies')

GENRES = MOVIES.find.to_a.inject([]) { |all, i| all + i['genres'] }.uniq!

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
