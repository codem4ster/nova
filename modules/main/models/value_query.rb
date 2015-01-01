class Main::Models::ValueQuery < Neo::Database::ModelQuery
	def belongs_to_data(data)
		self.add_match 'data', 'Data', {id: data.id}, '-[:HasValue]->n'
	end

	def belongs_to_property(property)
		self.add_match 'property', 'Property', {id: property.id}, '-[:HasValue]->n'
	end
end