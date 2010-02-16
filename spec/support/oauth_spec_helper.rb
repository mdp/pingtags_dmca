include FakewebHelpers


def ensure_oauth_success
  FakeWeb.register_uri(:post, 'https://api.linkedin.com/uas/oauth/accessToken', :body => 'oauth_token=fake&oauth_token_secret=fake')
  stub_get("https://api.linkedin.com/v1/people/~:(id,first-name,last-name,industry,headline,summary,picture-url,location,member-url-resources,public-profile-url)", 'profile.xml')
end