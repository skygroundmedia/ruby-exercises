#
#  First things First you need to install this ruby gem
#  sudo gem install ezcrypto
#

require 'ezcrypto'

class CryptoUtil
	# Make a strong alpha-numeric password longer then 8-bytes
	@@alphanum_password = "alph@_num3r1c"
	# Create a Salt or two-form hash
	@@salt = "salted hash"		

	def initialize
	end

	def random_key
		EzCrypto::Key.generate
	end

	#AES 128-bit Key
	def encrypt(password)
		# Encrypt the password
		encrypted = key.encrypt(password)
	end

	def decrypt(encrypted)
		#B. Decrypt the Original Message
		decrypted = key.decrypt(encrypted)
	end
	
	def key
		EzCrypto::Key.with_password(@@alphanum_password, @@salt)
	end
end

def show_message(message)
	puts %Q{#{message} \n\n}
end


crypto_util = CryptoUtil.new

encrypted = crypto_util.encrypt("$up3r_p@$$w0rd")
show_message("This is your encrypted password: " + encrypted)

decrypted = crypto_util.decrypt(encrypted)
show_message( "This is your decrypted password: " + decrypted)
