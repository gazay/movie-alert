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
  @time_filter = !(query.has_key?('year') or query.has_key?('release_date'))
  query['title'] = /\w/ unless query.has_key? 'title'
  
  if query.empty?
    @movies = Movies.find(query, {:limit => 100, :sort => {'poster' => 1, 'title' => 1 }}).to_a
#    @movies.sort! { |a, b|
#      a['poster'] <=> b['poster']
#    }.reject! { |i|
#      i['title'].nil? or i['title'] =~ /^\s*$/
#    }
  end
  
  if 'part' == format
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
      entry = Actors.find_one(:name => /#{value}/)
      value = entry
      key = 'actors'
    when 'director'
      entry = Directors.find_one(:name => /#{value}/)
      value = entry
    end
    [key, value]
  end]
end

def poster_thumb(poster_url, width, height)
  poster_url[0..-5] + "._V1._SX#{width}_SY#{height}_.jpg"
end

def format_date(date, year)
  date = Date.parse(date)
  
  day = if (11..13).include?(date.mday % 100)
    "#{date.mday}th"
  else
    case date.mday % 10
    when 1; "#{date.mday}st"
    when 2; "#{date.mday}nd"
    when 3; "#{date.mday}rd"
    else "#{date.mday}th"
    end
  end
  
  if year
    date.strftime("#{day} of %B, %Y")
  else
    date.strftime("#{day} of %B")
  end
end
