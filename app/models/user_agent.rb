class UserAgent

  class<<self

  def parse(ua)
    {
      :make => self.make(ua),
      :model => self.model(ua)
    }
  end
  
  def class(ua)
    case ua
    when /iphone/i
      "iphone"
    when /android/i
      "android"
    when /blackberry/i
      "blackberry"
    when /Windows CE/i
      "msmobile"
    when /firefox/i
      "desktop"
    when /MSIE/
      "desktop"
    else
      "wap"
    end
  end
  
  def make(ua)
    case ua
    when /iphone/i
      "iphone"
    when /android/i
      "android"
    when /blackberry/i
      "blackberry"
    when /Windows CE/i
      "msmobile"
    when /firefox/i
      "desktop"
    when /MSIE/
      "desktop"
    else
      "unknown"
    end
  end
  
  def model(ua)
    "Not Yet Implemented"
  end

  end

  
end
