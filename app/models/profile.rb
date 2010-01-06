class Profile
  
  attr_reader :user_agent
  
  def initialize(ua)
    @user_agent = ua
  end
  
  def make
    case user_agent
    when /Windows CE/i
      "MS Mobile"
    when /firefox/i
      "Desktop"
    when /MSIE/
      "Desktop"
    when /iphone/i
      "iPhone"
    when /Mozilla/
      "Desktop"
    when /android/i
      "Android"
    when /blackberry/i
      "Blackberry"
    else
      "Unknown"
    end
  end
  
  def model
    "Not Yet Implemented"
  end

  
end
