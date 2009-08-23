module Subscription
  extend self
  
  attr_accessor :movies_with_release_date
  
  def add_sub(targets, sym, value)
    Subs.insert(:targets => targets, sym => value)
  end
  
  def add_email(targets, new_mail)
    if new_mail.match /^[a-zA-Z0-9]+([_.-]?[a-zA-Z0-9]+)?@[a-zA-Z0-9]+([_-]?[a-zA-Z0-9]+)*([.]{1})[a-zA-Z0-9]+([.]?[a-zA-Z0-9]+)*$/
      add_sub(targets, :email, new_mail) if Subs.find(:targets => targets, :email => new_mail).count == 0
    end
  end
  
  def add_twit(targets, new_twit)
    if new_twit.match /^[a-zA-Z0-9_]+$/
      add_sub(targets, :twit, new_twit) if Subs.find(:targets => targets, :twit => new_twit).count == 0
    end
  end
  
  def clear
    movies_with_release_date = nil
  end
end