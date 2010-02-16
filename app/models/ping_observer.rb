class PingObserver < ActiveRecord::Observer
  def after_create(ping)
    Notifier.deliver_ping_notification(ping.sender, ping.recipient)
  end
end
