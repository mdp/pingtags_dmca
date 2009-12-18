require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Contact do
  before(:all) do
    @valid_attributes = {
      :user_id => 1
    }
    @contact = Contact.create!(@valid_attributes)
  end

  it "should create a new instance given valid attributes" do
    Contact.create!(@valid_attributes)
  end
  
  it "should have a security_pin" do
    @contact.security_pin.should_not be_nil
  end
  
  it "should be capable of looking it up my pin and id in base36 format" do
    Contact.secure_code_lookup(@contact.secure_code).should eql(@contact)
  end
  
  it "should never change the security pin after creation" do
    old_secure_code = @contact.secure_code
    @contact.update_attributes(:name => "mark")
    @contact.secure_code.should == old_secure_code
  end
  
  it "should have a short_url" do
    p @contact.short_url
    @contact.short_url.should_not be_nil
  end
  
  it "should provide a QR image url" do
    p @contact.qr_image
    @contact.qr_image.should_not be_nil
  end
  
  it "should provide a QR image url with a size option" do
    p @contact.qr_image(580)
    @contact.qr_image.should_not be_nil
  end
  
  
end
