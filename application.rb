#!/usr/bin/env ruby

require 'dependencies'
require 'database'
require 'scripts/subscription'
require 'helpers'

get /^\/(index.(html|part))?$/ do
  @format = params['captures'] ? params['captures'][1] : 'html'
  @release_months = Cache.find_one(:name => 'release_months')['value']
  
  @offset = (params['offset'] || 0).to_i
  
  query = params_to_query(params)
  @empty_search = !query.empty?
  @time_filter = !(query.has_key?('year') or query.has_key?('release_date'))
  query['title'] = /\w/ unless query.has_key? 'title'
  
  if !query.has_key?('release_date') and 
    (!query.has_key?('year') or Date.today.year != query['year'])
    query['release_timestamp'] = {'$gt' => Date.today.strftime('%s').to_i}
  end
  
  sort = [{'poster_exists' => -1}]
  sort << ((@empty_search or !@time_filter) ? 'title' : 'release_timestamp')
  
  @all = Movies.find(query).count
  @movies = Movies.find(query, {:limit => 40, :sort => sort,
                                :offset => @offset}).to_a
  
  if request.cookies['flash']
    @flash = case request.cookies['flash']
    when 'subscribed'
      'We are notify you, when movies will be released.'
     end
     set_cookie('flash', '')
  end
  
  if request.xhr?
    haml :index, :layout => false
  else
    haml :index
  end
end

post '/subscribe' do
  targets = {}
  if params[:title] && params[:title] != 'Title'
    targets['title'] = params[:title]
  end
  targets['imdb_id'] = params[:imdb_id].to_i if params[:imdb_id]
  if params[:actor] && params[:actor] != 'Actor'
    targets['actor'] = params[:actor]
  end
  if params[:director] && params[:director] != 'Director'
    targets['director'] = params[:director]
  end
  if params[:genre] && params[:genre] != 'Genre'
    targets['genre'] = params[:genre]
  end
  targets = nil if targets == {}
  if targets
    result = Subscription.add_email(targets, params[:subs_mail]) ||
        Subscription.add_twit(targets, params[:subs_twit]) 
    set_cookie('flash', 'subscribed') if result
  end
  redirect '/'
end

get '/suggest/actor' do
  Actors.find({:name => /#{params['q']}/i }, 
      { :limit => params['limit'].to_i }).to_a.map { |i| i['name']}.join("\n")
end

get '/suggest/director' do
  Directors.find({:name => /#{params['q']}/i },
      { :limit => params['limit'].to_i }).to_a.map { |i| i['name']}.join("\n")
end
