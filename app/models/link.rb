class Link < ActiveRecord::Base
  belongs_to :scan
  before_validation :cleanup_url
  validates_format_of :destination, :with => /(http|https):\/\/(\w+:{0,1}\w*@)?(\S+)(:[0-9]+)?(\/|\/([\w#!:.?+=&%@!\-\/]))?/
  
  def icon
    "/images/icons/#{self.type.downcase}.png"
  end
  
  def tracked_url
    "http://pingtag.com/r/#{self.id}"
  end
  
  def cleanup_url
    url = read_attribute(:destination)
    if url =~ /(http|https):\/\/(\w+:{0,1}\w*@)?(\S+)(:[0-9]+)?(\/|\/([\w#!:.?+=&%@!\-\/]))?/
      write_attribute(:destination, url)
    elsif "http://#{url}" =~ /(http|https):\/\/(\w+:{0,1}\w*@)?(\S+)(:[0-9]+)?(\/|\/([\w#!:.?+=&%@!\-\/]))?/
      write_attribute(:destination, "http://#{url}")
    end
  end
  
end
