#!/usr/bin/env ruby

require 'rubygems'
require 'sinatra'
require 'haml'

get '/' do
  haml :index
end

%w{actor director}.each do |type|
  get "/suggest/#{type}" do
    #TODO
  end
end

get '/movies/' do
  #TODO
end
