require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe UserSessionsController do

  #Delete this example and add some real ones
  it "should use UserSessionsController" do
    controller.should be_an_instance_of(UserSessionsController)
  end
  
  describe "creating an account via signup" do
    
    before :each do
      ensure_oauth_success
      @user = Factory.create(:user)
    end
    
    it 'should create a new account' do
      User.should_receive(:create_or_update_with_access_token).and_return(@user)
      Ping.should_not_receive(:create)
      get :oauth_callback, {:oauth_verifier => 'foo'}, {:email => 'mark@mark.com'}
    end
    
  end
  
  describe "creating an account via ping" do
    
    before :each do
      ensure_oauth_success
      @pinged_user = Factory.create(:user)
      @pinger = Factory.create(:user)
    end
    
    it 'should create a new account and ping' do
      User.stub!(:find_by_crypt_id).and_return(@pinged_user)
      User.stub!(:create_or_update_with_access_token).and_return(@pinger)
      Ping.should_receive(:create).with(:sender => @pinger, :recipient => @pinged_user)
      get :oauth_callback, {:oauth_verifier => 'foo'}, {:user_crypt_id => '12345', :source => 'ping'}
    end
    
  end

end
