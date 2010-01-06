class UserAgent

  class<<self

  def parse(ua)
    {
      :make => self.make(ua),
      :model => self.model(ua)
    }
  end
  
  def make(ua)
    case ua
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
  
  def model(ua)
    "Not Yet Implemented"
  end

  end

  
end
