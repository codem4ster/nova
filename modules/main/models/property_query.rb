class Main::Models::PropertyQuery < Neo::Database::ModelQuery
	def with_name(name)
		self.add_where([%w[name = {name}]]).add_parameters name: name
	end
end