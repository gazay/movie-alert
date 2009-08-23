#!/usr/bin/env ruby

require File.join(File.dirname(__FILE__), '..', 'database')
require File.join(File.dirname(__FILE__), '..', 'send')

def find_subs(day, movies)
  subs = Subs.find().to_a
  
  subs.each do |sub|
    movies.each do |movie|
      can_send = nil
      sub['targets'].each do |key, value|
        puts key.inspect + ' - ' + value.inspect
        if key == 'director'
          can_send = movie[key] == value
        else
          can_send = movie[key + 's'].include? value
        end
      end
      if can_send && sub['twit']
        Send.twit :to_user => sub['twit'],
                  :message => day +
                    ' release date of ' + movie['title'] + 
                    '. Link: http://www.imdb.com/title/tt' + 
                    movie['imdb_id'] + '/'
        puts 'Send to @' + sub['twit']
      elsif can_send && sub['email']
        Send.mail :to => sub['email'],
                  :subject => day +
                    ' release date of ' + 
                    movie['title'] + '.',
                  :body => 'Link to film: ' +
                    'http://www.imdb.com/title/tt' + 
                    movie['imdb_id'] + '/'
      end                          
    end
  end 
end

find_subs('Tomorow', Movies.find(:release_date => (Date.today + 1).to_s).to_a)
find_subs('Next week', Movies.find(:release_date => (Date.today + 7).to_s).to_a)