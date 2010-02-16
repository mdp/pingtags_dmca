require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe User do
  before(:each) do
    ensure_oauth_success
    xml = mock(:xml, :body => File.read('spec/fixtures/profile.xml'))
    @access_token = mock('AccessToken', :get => xml, :secret => 'itsasecret', :token => 'Tolken')
  end

  it "should send a signup email" do
    User.create_or_update_with_access_token(@access_token, :email => 'mark@mark.com')
    ActionMailer::Base.deliveries.count.should eql(1)
  end
  
end