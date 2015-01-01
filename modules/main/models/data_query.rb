class Main::Models::DataQuery < Neo::Database::ModelQuery
	def with_key(key)
		self.add_where([%w[key = {key}]]).add_parameters key: key
	end
end