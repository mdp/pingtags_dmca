require 'uri'

class User < ActiveRecord::Base
  has_many :scans
  has_many :pings, :foreign_key => 'recipient_id'
  
  acts_as_authentic do |c|
    c.validate_email_field = false
  end
  
  # We create accounts before email sometimes, so allow nil until it's set
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :allow_nil => true
  
  def self.create_or_update_with_access_token(access_token, opts = {})
    path = "/v1/people/~:(id,first-name,last-name,industry,headline,summary,picture-url,location,member-url-resources,public-profile-url)"
    profile = Nokogiri::XML.parse(access_token.get(path).body)
    li_id = profile.xpath('//id').first.content.strip
    user = User.find_or_initialize_by_linked_in_id(li_id)
    user.attributes = {
      :profile_xml => profile.to_s,
      :access_token => access_token.token,
      :secret_token => access_token.secret
    }
    if opts[:email] && !opts[:email].blank?
      user.email = opts[:email]
    end
    user.save
    user
  end
  
  def self.find_by_crypt_id(id)
    if user = self.find(cipher.decode(id.to_i(36)))
      user
    else
      raise ActiveRecord::NotFound
    end
  end
  
  def url
    "http://#{SHORT_DOMAIN}/#{crypted_id}".downcase
  end
  
  def barcode(size = 150, padding = 1)
    "http://chart.apis.google.com/chart?chs=#{size}x#{size}&cht=qr&chl=#{URI.escape(self.url)}&chld=L|#{padding}"
  end
    
  def crypted_id
    self.class.cipher.encode(self.id).to_s(36)
  end
  
  def update_status
    "I just signed up for my PingTag at <a href='http://pingtags.com'>http://pingtags.com</a>"
  end
  
  def name
    "#{self.first_name} #{self.last_name}"
  end
  
  def profile
    @profile ||= Nokogiri::XML.parse(profile_xml)
  end
  
  def links
    lnks = []
    if profile.xpath('//member-url-resources')
      profile.xpath('//member-url-resources/member-url').each do |url|
        lnks << {:name => url.xpath('name').inner_text.to_s.strip, :url => url.xpath('url').inner_text.to_s.strip}
      end
    end
    lnks
  end
  
  def public_profile_url
    url = profile.xpath('//public-profile-url').inner_text.to_s.strip
    url.blank? ? nil : url
  end
  
  def last_name
    profile.xpath('//last-name[1]').inner_text.to_s.strip
  end
  
  def first_name
    profile.xpath('//first-name[1]').inner_text.to_s.strip
  end
  
  def summary
    profile.xpath('//summary[1]').inner_text.to_s.strip
  end
  
  def headline
    profile.xpath('//headline[1]').inner_text.to_s.strip
  end
  
  def picture_url
    unless profile.xpath('//picture-url[1]').inner_text.to_s.strip.blank?
      profile.xpath('//picture-url[1]').inner_text.to_s.strip
    end
  end
  
  def industry
    profile.xpath('//industry[1]').inner_text.to_s.strip
  end


  private
  
  def self.cipher
    @cipher ||= FourBitesAES.new("KittenMittens!!!")
  end

end
