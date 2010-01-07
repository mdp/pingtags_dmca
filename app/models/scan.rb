require 'ipaddr'
require 'digest'
require 'openssl'

class Scan < ActiveRecord::Base
  HMAC_KEY = "Fuck Chilkat and their fucking google spam for HMAC Ruby libraries." unless defined?(HMAC_KEY)
  belongs_to :user
  belongs_to :device
  has_many :clicks
  
  default_scope :order => 'created_at DESC'
  
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
  
  def hmac
    OpenSSL::HMAC.hexdigest(OpenSSL::Digest::Digest.new('sha1'), HMAC_KEY, self.id.to_s)
  end
  
end
