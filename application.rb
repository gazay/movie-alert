#!/usr/bin/env ruby

require 'rubygems'
require 'sinatra'
require 'haml'
require 'database'
require 'scripts/subscription'
require 'helpers'

get /^\/(index.(html|part))?$/ do
  @format = params['captures'] ? params['captures'][1] : 'html'
  @release_months = Cache.find_one(:name => 'release_months')['value']
  
  @offset = (params['offset'] || 0).to_i
  
  query = params_to_query(params)
  @time_filter = !(query.has_key?('year') or query.has_key?('release_date'))
  query['title'] = /\w/ unless query.has_key? 'title'
  
  sort = [{'poster_exists' => -1}]
  sort << (@time_filter ? 'title' : 'release_date')
  
  @all = Movies.find(query).count
  @movies = Movies.find(query, {:limit => 60, :sort => sort,
                                :offset => @offset}).to_a

  if request.xhr?
    haml :index, :layout => false
  else
    haml :index
  end
end

get '/subscribe' do
  targets = {}
  targets['title'] = params[:title] if params[:title] != 'Title'
  targets['actor'] = params[:actor] if params[:actor] != 'Actor'
  targets['director'] = params[:director] if params[:director] != 'Director'
  targets['genre'] = params[:genre] if params[:genre] != 'Genre'
  targets = nil if targets == {}
  if targets
    Subscription.add_email(targets, params[:subs_mail])
    Subscription.add_twit(targets, params[:subs_twit]) 
  end
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
