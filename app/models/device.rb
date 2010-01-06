class Device < ActiveRecord::Base
  has_many :scans
  
  def make
    UserAgent.parse(self.user_agent)[:make]
  end

end