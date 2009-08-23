#!/usr/bin/env ruby

require 'rubygems'
require 'sinatra'
require 'haml'
require 'database'
require 'scripts/subscription'

get /^\/(index.(html|part))?$/ do
  format = params['captures'] ? params['captures'][1] : 'html'
  
  @release_months = Cache.find_one(:name => 'release_months')['value']
  query = params_to_query(params)
  if query.empty?
    @movies = [] #TODO
  else
    @movies = Movies.find(query, {:limit => 1000}).to_a
    @movies.sort! do |a, b|
      if not a['poster'] and b['poster']
        1
      elsif a['poster'] and not b['poster']
        -1
      else
        a['title'].to_s <=> b['title'].to_s
      end
    end
  end
  
  if 'part' == format
    haml :index, :layout => false
  else
    haml :index
  end
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
  puts params['q']
  Directors.find({:name => /#{params['q']}/i},
      {:limit => params['limit'].to_i}).to_a.map { |i| i['name']}.join("\n")
end

def params_to_query(params)
  params.delete('captures')
  Hash[params.to_a.map do |key, value|
    case key
    when 'year'
      value = value.to_i
    when 'release_date'
      value = /^#{value}/
    when 'title'
      value = /#{value}/
    when 'genre'
      entry = Genres.find_one(:name => value)
      value = entry
      key = 'genres'
    when 'actor'
      entry = Actors.find_one(:name => value)
      value = entry
      key = 'actors'
    when 'director'
      entry = Directors.find_one(:name => value)
      value = entry
    end
    [key, value]
  end]
end

def poster_thumb(poster_url, width, height)
  poster_url[0..-5] + "._V1._SX#{width}_SY#{height}_.jpg"
end
