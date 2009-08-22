#!/usr/bin/env ruby

require 'rubygems'
require 'sinatra'
require 'haml'
require 'database'
require 'scripts/subs'

get '/' do
  @movies = []
  haml :index
end

get '/subscribe' do
  targets = {}
  targets['title'] = params[:movie_title] if params[:movie_title]
  targets['actor'] = params[:movie_actor] if params[:movie_actor]
  targets['director'] = params[:movie_director] if params[:movie_director]
  Subs.add_email(targets, params[:subs_mail])
  Subs.add_twit(targets, params[:subs_mail]) 
end

%w{actor director}.each do |type|
  get "/suggest/#{type}" do
    #TODO
  end
end
