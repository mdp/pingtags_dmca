require 'four_bites_aes'
require 'digest/sha2'
require 'benchmark'

# The key should be 256 bits long, a SHA2 hex string for example
key = Digest::SHA2.hexdigest("It's only going to encrypt 4 bytes!!!")

DB_CRYPT = FourBitesAES.new(key)

n = 1000
Benchmark.bm do |x|
  x.report("Cycle #{n} times") { 
    n.times {
      enc = DB_CRYPT.enc(n)
      dec = DB_CRYPT.dec(enc)
    }
  }
end

10.times  { |i|
  p enc = DB_CRYPT.enc(i)
  p dec = DB_CRYPT.dec(enc)
}