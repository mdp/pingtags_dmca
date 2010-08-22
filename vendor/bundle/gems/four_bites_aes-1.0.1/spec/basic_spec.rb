require 'spec'
require "lib/four_bites_aes"

describe "A really super secure id encrypter" do
  
  before(:all) do
    @crypter = FourBitesAES.new("password")
  end
  
  it "should encode and decode an id" do
    eid = @crypter.encode(12345)
    @crypter.decode(eid).should eql 12345
  end
  
  
end