Four Bites AES
==============
Author: Mark Percival  
Email: mark@mpercival.com  
Copyright: Mark Percival 2008  
License: MIT 

-----------

This is a simple library that takes any 4 byte integer and encrypts it with a modified version of AES.
It's designed with URL shorteners in mind, where brevity is key, and security through obscurity is OK.

Two goals with this project

- Keep the total number of records somewhat secret
- Prevent people from easily guessing the next record

mySQL integers are 4 bytes long, so I wanted to account for that, and keep the encrypted number the same length.

I certainly wouldn't base my security on this system.

This library isn't designed to prevent sophisticated attacks. It's simple designed to keep your total record count
secret, and prevent the average joe/jane from easily guessing the next number, all in the shortest 
possible manner.


### Details about the code

I followed the AES standard as much as possible, except I used 8 rounds, and a 256 bit unexpanded key. The ShiftRows
method became a rotation of the 4 bytes, and the MixColumns became one single column mix. Other than that, it's essentially 
the same algorithm.

## Example code

        class Link < ActiveRecord::Base
          require 'four_bites_aes'

          def to_param
            @crypte.encode(self.id)
          end
        
          def find(id)
            self.find(@crypter.decode(id))
          end
        
          def encoder
            @crypter ||= FourBitesAES.new("supersecret")
          end

        end