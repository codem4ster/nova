class Auth::Components::Password

	attr_accessor :salt

	def initialize(plain)
		@plain = plain
	end

	def generate_salt
		@salt = 32.random_char
	end

	def encoded
		"#{@salt}#{@plain}".to_md5
	end

	def identical?(encoded_pass)
		encoded == encoded_pass
	end

end