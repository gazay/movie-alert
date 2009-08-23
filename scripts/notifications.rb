#!/usr/bin/env ruby

require File.join(File.dirname(__FILE__), '..', 'database')
require File.join(File.dirname(__FILE__), '..', 'send')

def links2names(movies)
  movies.each do |movie|
    if movie['title']
      puts movie['title']
      movie['actors'].map! do |ref|
        actor = Actors.find('_id' => ref).first
        if actor
          ref = actor['name']
        else
          ref = ref['name']
        end
      end

      director = Directors.find('_id' => movie['director']).first
      movie['director'] = director['name'] if director

      movie['genres'].map! do |ref|
        genre = Genres.find(ref).first
        if genre
          ref = genre['name']
        else
          ref = ref['name']
        end
      end
    end
  end
  movies.reject {|movie| movie['title'].nil?}
end

def find_subs(day, movies)
  subs = Subs.find().to_a
  # subs_mail = Subs.find(:twit => nil).to_a
  
  subs.each do |sub|
    movies.each do |movie|
      can_send = nil
      sub['targets'].each do |key, value|
        can_send = movie[key].include? value
      end
      if can_send && sub['twit']
        Send.twit :to_user => sub['twit'],
                  :message => day +
                    ' release date of ' + movie['title'] + 
                    '. Link: http://www.imdb.com/title/tt' + 
                    movie['imdb_id'] + '/'
      elsif sub['email']
        Send.mail :to => sub['email'],
                  :subject => day +
                    ' release date of ' + 
                    movie['title'] + '.',
                  :body => 'Link to film: ' +
                    'http://www.imdb.com/title/tt' + 
                    movie['imdb_id'] + '/'
        puts 'send to ' + sub['email']
      end                          
    end
  end 
end

tomorow_movies = links2names Movies.find(:release_date => (Date.today + 1).to_s).to_a
next_week_movies = links2names Movies.find(:release_date => (Date.today + 7).to_s).to_a

find_subs('Tomorow', tomorow_movies)
find_subs('Next week', next_week_movies)