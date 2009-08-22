require '../database.rb'

module Subscriptions
  def add_sub(targets, emails, twits)
    Subscription.create(:targets => targets, :emails => emails, :twits => twits)
  end
  
  def add_email(targets, new_mail)
    s = Subscription.find(:targets => targets)
    s.emails << new_email
    s.save
  end
  
  def add_twit(targets, new_twit)
    s = Subscription.find(:targets => targets)
    s.twits << new_twit
    s.save
  end
  
  def find_movies_by_subs(targets)
    Movie.find(targets).where(this.release_date >= Date.today)
  end
end