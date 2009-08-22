module Subscription
  extend self
  
  attr_accessor :movies_with_release_date
  
  def add_sub(targets, emails, twits)
    Subs.create(:targets => targets, :emails => emails, :twits => twits)
  end
  
  def add_email(targets, new_mail)
    if new_mail.match /^[a-zA-Z0-9]+
      ([_.-]?[a-zA-Z0-9]+)?@[a-zA-Z0-9]+([_-]?[a-zA-Z0-9]+)*([.]{1})
      [a-zA-Z0-9]+([.]?[a-zA-Z0-9]+)*$ /
      s = Subs.find(:targets => targets)
      if s
        s.emails << new_email
        s.save
      else
        add_sub(targets, [new_mail], [])
      end
    end
  end
  
  def add_twit(targets, new_twit)
    if new_twit.match /^[a-zA-Z0-9_]+$/
      s = Subs.find(:targets => targets)
      if s
        s.twits << new_twit
        s.save
      else
        add_sub(targets, [], [twit])
      end
    end
  end
  
  def find_movies_by_subs(targets)
    movies_with_release_date ||= Movie.find(targets, :where => 'this.release_date != null')
    
  end
  
  def clear
    movies_with_release_date = nil
  end
end