require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Ping do
  before(:each) do
    @user1 = Factory.create(:user)
    @user2 = Factory.create(:user)
    ActionMailer::Base.deliveries = [] #reset from the signup new user emails
  end

  it "should send a signup email" do
    Ping.create(:sender => @user1, :recipient => @user2)
    ActionMailer::Base.deliveries.count.should eql(1)
  end
  
end