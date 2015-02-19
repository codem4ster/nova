class Auth::Models::Member < Auth::Models::User
  MemberQuery = Auth::Models::MemberQuery
  Password = Auth::Components::Password
  Transaction = Neo::Database::Transaction
  Role = Auth::Models::Role

  attr_accessor :username, :email, :password, :salt, :active
  attr_accessor :activation_code, :pass_requested_at, :pass_request_code
  attr_accessor :hidden_answer, :last_login, :signed_at

  def initialize
    @labels = 'User:Member'
  end

  # static methods

  # looks the database for availability of username or email
  #   these fields must be unique
  def self.available?(username, email)
	  MemberQuery.new.by_username_or_email(username, email).count == 0
  end

  # Creates a member with the given role
	def self.create(username, email, password, role)

		unless available?(username, email)
			Neo::Exceptions::SystemError.new(
				Neo::trn('Username or email has already been registered')
			).raise
		end

		password = Password.new(password)
		password.generate_salt

		member = self.new
		member.username = username
		member.email = email
		member.password = password.encoded
		member.salt = password.salt
		member.active = true
		member.signed_at = Time.now.to_i

		Transaction.create do
			member.save
			role = Role.create_unique(role)
			member.relate_to role, 'HasRole'
		end

	end

  # Checks and authenticates user with username and password
  # @return [true,false] true if authentication is successfull
	def self.authenticate(username, password)
		member = MemberQuery.new.by_username(username).find_one
		if member
			password = Password.new(password)
			password.salt = member.salt
			result = password.identical?(member.password)
			Neo::Params::Session[:member] = member if result
			result
		else
			false
		end
	end

  # @return [Member] logged user
	def self.logged_in
		Neo::Params::Session[:member]
  end

  def self.logout
    Neo::Params::Session.delete(:member)
  end

end
