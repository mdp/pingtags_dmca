require 'uri'

class User < ActiveRecord::Base
  acts_as_authentic do |c|
    c.validate_email_field = false
  end
  
  def self.initialize_with_access_token(access_token)
    path = "/v1/people/~:(id,first-name,last-name,industry,headline,summary,picture-url,location,member-url-resources)"
    profile = Nokogiri::XML.parse(access_token.get(path).body)
    li_id = profile.xpath('//id').first.content.strip
    user = User.find_or_initialize_by_linked_in_id(li_id)
    user.attributes = {
      :profile_xml => profile.to_s,
      :access_token => access_token.token,
      :secret_token => access_token.secret
    }
    if user.save
      user
    else
      nil
    end
  end
  
  def self.find_by_crypt_id(id)
    self.find(cipher.decode(id.to_i(36)))
  end
  
  def url
    "HTTP://#{SHORT_DOMAIN}/#{crypted_id}"
  end
  
  def barcode
    "http://chart.apis.google.com/chart?chs=150x150&cht=qr&chl=#{URI.escape(self.url)}"
  end
    
  def crypted_id
    self.class.cipher.encode(self.id).to_s(36).upcase
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
    profile.xpath('//picture-url[1]').inner_text.to_s.strip    
  end
  
  def industry
    profile.xpath('//industry[1]').inner_text.to_s.strip    
  end


  private
  
  def self.cipher
    @cipher ||= FourBitesAES.new("KittenMittens!!!")
  end

end