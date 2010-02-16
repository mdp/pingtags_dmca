class Notifier < ActionMailer::Base
  def ping_notification(sender, recipient)
    recipients recipient.email
    from       "pingtags@squarepush.com"
    subject    "New ping"
    body       :sender => sender, :recipient => recipient
    content_type "text/html"
  end
  
  def signup_notification(user)
    recipients user.email
    from       "pingtags@squarepush.com"
    subject    "Your New PingTag Account"
    body       :user => user
    content_type "text/html"
  end

end
