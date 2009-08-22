#!/usr/bin/env ruby

require 'rubygems'
require 'sinatra'
require 'haml'
require 'database'
require 'scripts/subscription'

get '/' do
  @movies = []
  haml :index
end

get '/subscribe' do
  targets = {}
  targets['title'] = params[:movie_title] if params[:movie_title]
  targets['actor'] = params[:movie_actor] if params[:movie_actor]
  targets['director'] = params[:movie_director] if params[:movie_director]
  Subscription.add_email(targets, params[:subs_mail])
  Subscription.add_twit(targets, params[:subs_twit]) 
  redirect '/'
end

%w{actor director}.each do |type|
  get "/suggest/#{type}" do
    params['q']
    params['limit']
    "A\nB\n"
  end
end
