class Device < ActiveRecord::Base
  has_many :scans
  
  def make
    Profile.new(self.user_agent).make
  end

end