require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Click do
  before(:each) do
    @valid_attributes = {
      :link_id => 1,
      :scan_id => 1
    }
    @click = Click.create!(@valid_attributes)
  end

  it "should create a new instance given valid attributes" do
    Click.create!(@valid_attributes)
  end
  
  
end
