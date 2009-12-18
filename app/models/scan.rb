require 'ipaddr'
require 'digest'

class Scan < ActiveRecord::Base
  belongs_to :user
  
  before_create :build_tracking_cookie
  
  def ip_address=(ip)
    if ip.instance_of?(String)
      write_attribute(:ip_address, IPAddr.new(ip).to_i)
    elsif ip.instance_of?(Fixnum)
      write_attribute(:ip_address, ip)
    end
  end
  
  def ip_address
    IPAddr.new(read_attribute(:ip_address), Socket::AF_INET).to_s
  end
  
  def make
    UserAgent.parse(self.user_agent)[:make]
  end
  
  private
  
  def build_tracking_cookie
    unless self.tracking_cookie
      self.tracking_cookie = Digest::SHA256.hexdigest(Time.now.to_s)
    end
  end
  
end
