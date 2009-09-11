require 'twitter'
require 'pony'

module Send
  extend self
  
  def twit(options)
    twitter = Twitter::Client.new(:login => 'movie_alert', :password => '13579qetuo')
    twitter.message(:post, options[:message], options[:to_user])
  end
  
  def mail(options)
    Pony.mail :to => options[:to],
              :from => 'mov.alert@gmail.com', 
              :subject => options[:subject],
              :body => options[:body]
  end
end