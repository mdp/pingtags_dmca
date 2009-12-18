require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe UserAgent do
  before(:each) do

  end

  it "should find Firefox as a browser" do
    UserAgent.class("Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.5; en-US; rv:1.9.0.11) Gecko/2009060214 Firefox/3.0.11").should == 'desktop'
  end
  
end
