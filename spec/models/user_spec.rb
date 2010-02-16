require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe User do
  before(:each) do
    ensure_oauth_success
    xml = mock(:xml, :body => File.read('spec/fixtures/profile.xml'))
    @access_token = mock('AccessToken', :get => xml, :secret => 'itsasecret', :token => 'Tolken')
    ActionMailer::Base.deliveries = []
  end

  it "should send a signup email" do
    User.create_or_update_with_access_token(@access_token, :email => "mark@mpercival.com")
    ActionMailer::Base.deliveries.count.should eql(1)
  end
  
  it "should not send a signup email to a user without an address" do
    User.create_or_update_with_access_token(@access_token, :email => nil)
    ActionMailer::Base.deliveries.count.should eql(0)
  end
  
end