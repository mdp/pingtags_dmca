When /^I choose to authenticate with LinkedIn$/ do
  FakeWeb.register_uri(:post, "https://api.linkedin.com/uas/oauth/requestToken", :body => 'oauth_token=fake&oauth_token_secret=fake')
  click_link 'here'
end

# I should be redirected to "linkedin.com"
Then /^I should be redirected to "([^\"]*)"$/ do |domain|
  response.header['location'].should match(/#{domain}/)
end

Then /^I should be logged in$/ do
  controller.current_user.should_not be_nil
  
end


Given /^I authorize PingTags$/ do
end

Given /^I signup with an email$/ do
  FakeWeb.register_uri(:post, "https://api.linkedin.com/uas/oauth/requestToken", :body => 'oauth_token=fake&oauth_token_secret=fake')
  visit '/signup'
  fill_in :email, :with => 'mark@mark.com'
  click_button 'Signup using LinkedIn'
end

When /^I return to PingTags$/ do
  FakeWeb.register_uri(:post, 'https://api.linkedin.com/uas/oauth/accessToken', :body => 'oauth_token=fake&oauth_token_secret=fake')
  stub_get("https://api.linkedin.com/v1/people/~:(id,first-name,last-name,industry,headline,summary,picture-url,location,member-url-resources,public-profile-url)", 'profile.xml')
  visit oauth_callback_path(:oauth_verifier => 'foo')
end
