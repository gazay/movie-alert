#!/usr/bin/env ruby

require 'rubygems'
require 'sinatra'
require 'haml'
require 'database'

get '/' do
  @movies = []
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
