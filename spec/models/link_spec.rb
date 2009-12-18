require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Link do
  before(:each) do
    @valid_attributes = {
      :destination => "mark.com"
    }
  end

  it "should create a new instance given valid attributes and prefix simple urls" do
    link = Link.create!(@valid_attributes)
    link.destination.should == "http://mark.com"
  end
  
  it "should accept url prefixed with http://" do
    link = Link.create!(@valid_attributes.merge(:destination => 'http://mark.com/test?test=1'))
    link.destination.should == "http://mark.com/test?test=1"
  end
  
end
