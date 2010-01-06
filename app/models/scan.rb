require 'ipaddr'
require 'digest'

class Scan < ActiveRecord::Base
  belongs_to :user
  belongs_to :device
  has_many :clicks
  
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
  
end
