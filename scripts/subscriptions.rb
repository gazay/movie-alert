require '../database.rb'

module Subscriptions
  def add_sub(targets, emails, twits)
    Subscription.create(:targets => targets, :emails => emails, :twits => twits)
  end
  
  def add_email(targets, new_mail)
    s = Subscription.find(:targets => targets)
    s.emails << email
    s.save
  end
end