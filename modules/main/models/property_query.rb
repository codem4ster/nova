class Main::Models::PropertyQuery < Neo::Database::ModelQuery
	def with_name(name)
		self.add_where([%w[name = {name}]]).add_parameters name: name
	end

	def with_model(model_name)
		self.add_match('model','Model',{name: model_name}, '-[r:HasProperty]->n')
	end

	def with_data(key)
		self.add_match('d','Data', {key: key}, '<-[r:HasData]-n')
	end
end