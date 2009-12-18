class LinkedIn
  
  def self.client
    OAuth::Consumer.new("wrKY3SLqnHP0r1eVor6AcKYKr8Pw4-5HVQohOQ7FJsculKQnHv3Pm7voxOBMTZ0o", 
                        "zWzzU96-_u4Lp0VgDiq1cop_0i28OTOwSbBre7VUx0dd3SntOk4sOnkCjE8j8wBH",
                        :site => "https://api.linkedin.com",
                        :request_token_path => "/uas/oauth/requestToken",
                        :access_token_path  => "/uas/oauth/accessToken",
                        :authorize_path     => "/uas/oauth/authorize"
                        )
  end
  
end