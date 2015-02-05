class Auth::Commands::CreateAdmin < Neo::Command
	Member = Auth::Models::Member
	def run(username, email, password)
		Member.create username, email,  password, 'Admin'
	end
end