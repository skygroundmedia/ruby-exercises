#
#  First things First you need to install this ruby gem
#  sudo gem install ezcrypto
#

############################
#1. Encryption
############################
#A. Import the Libraries
require 'rubygems'
require 'ezcrypto'

#B. Create AES 128-bit Key
# => 1. Make a strong alpha-numeric password longer then 8-bytes
# => 2. Create a Salt or two-form hash
@key = EzCrypto::Key.with_password("alph@_num3r1c", "salted hash")

#C. Encrypt the Data
@encrypted = @key.encrypt "$up3r_p@$$w0rd"

puts "This is your encrypted data \n" + @encrypted

############################
#2. Decryption
############################
#A. Establish the Key like you did in Step A above

#B. Decrypt the Original Message
@decrypted = @key.decrypt @encrypted

puts "This is the decrypted original data \n" + @decrypted