#!/usr/bin/env ruby

require 'rubygems'
require 'sinatra'
require 'haml'
require 'database'
require 'scripts/subscription'

get '/' do
  @release_months = Cache.find_one(:name => 'release_months')['value']
  if params.empty?
    @movies = [] #TODO
  else
    @movies = Movies.find(params_to_query(params))
  end
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

get '/suggest/actor' do
  Actors.find({:name => /#{params['q']}/i},
      {:limit => params['limit'].to_i}).to_a.map { |i| i['name']}.join("\n")
end

get '/suggest/director' do
  Directors.find({:name => /#{params['q']}/i},
      {:limit => params['limit'].to_i}).to_a.map { |i| i['name']}.join("\n")
end

def params_to_query(params)
  Hash[params.to_a.map do |key, value|
    case key
    when 'year'
      value = value.to_i
    when 'release_date'
      value = /^#{value}/
    when 'title'
      value = RegExp.new(value)
    end
    [key, value]
  end]
end
