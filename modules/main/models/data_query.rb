class Main::Models::DataQuery < Neo::Database::ModelQuery
	def with_key(key)
		self.add_where([%w[key = {key}]]).add_parameters key: key
	end

	def with_model(name)
		self.add_match('model','Model', {name: name}, '-[:HasData]->n')
	end

	def with_data(key)
		self.add_match('d','Data', {key: key}, '<-[r:HasData]-n')
	end
end