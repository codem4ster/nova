class Performance::Models::User < Neo::Database::Model
	attr_accessor :name, :age, :profile_info

	def initialize
		@labels = 'PerfUser'
	end
end