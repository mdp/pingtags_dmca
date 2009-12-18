require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Scan do
  before(:all) do
    @valid_attributes = {
      :qr => true,
      :ip_address => '255.255.0.255',
      :contact_id => 1,
      :user_agent => "Mozilla/5.0 (iPhone; U; CPU like Mac OS X; en) AppleWebKit/420+ (KHTML, like Gecko) Version/3.0 Mobile/1A543a Safari/419.3 "
    }
    @valid_scan = Scan.create!(@valid_attributes)
  end

  it "should create a new instance given valid attributes" do
    Scan.create!(@valid_attributes)
  end
  
  it "should properly integerize a IP address" do
    @valid_scan.ip_address.should ==("255.255.0.255")
  end
  
  it "should parse the user_agent string into a make and model" do
    @valid_scan.ip_address.should ==("255.255.0.255")
  end
  
  it "should parse the user agent correctly" do
    @valid_scan.make.should == "iPhone"
  end
  
end
