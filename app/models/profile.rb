class Profile
  
  attr_reader :user_agent
  
  def initialize(ua)
    @user_agent = ua
  end
  
  def make
    case user_agent
    when /iphone/i
      "iPhone"
    when /android/i
      "Android"
    when /blackberry/i
      "Blackberry"
    when /Windows CE/i
      "MS Mobile"
    when /firefox/i
      "Desktop"
    when /MSIE/
      "Desktop"
    when /Mozilla/
      "Desktop"
    else
      "Unknown"
    end
  end
  
  def model
    "Not Yet Implemented"
  end

  
end
