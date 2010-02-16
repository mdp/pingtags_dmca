class Notifier < ActionMailer::Base
  def ping_notification(sender, recipient)
    return nil unless recipient.email
    recipients recipient.email
    from       "pingtags@squarepush.com"
    subject    "New ping"
    body       :sender => sender, :recipient => recipient
  end
  
  def signup_notification(user)
    return nil unless user.email
    recipients user.email
    from       "pingtags@squarepush.com"
    subject    "Your New PingTag Account"
    body       :user => user
  end

end
