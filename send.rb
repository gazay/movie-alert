require 'twitter'
require 'pony'

module Send
  extend self
  
  def twit(message, to_user=nil, users=[])
    twitter = Twitter::Client.from_config('files/twit_credentials.yml')
    twitter.message(:post, message, to_user) if to_user
    users.each do |usr|
      twitter.message(:post, message, usr) if usr
    end
  end
  
  def mail(to, subject, body)
    Pony.mail :to => to, 
              :from => 'mov.alert@gmail.com', 
              :subject => subject,
              :body => body
  end
end