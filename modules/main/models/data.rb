class Main::Models::Data < Neo::Database::Model
	DataQuery = Main::Models::DataQuery
	ValueQuery = Main::Models::ValueQuery
	Value = Main::Models::Value

	attr_accessor :key

	def initialize
		@labels = 'Data'
	end

	def get_values
		ValueQuery.new.belongs_to_data(self).find
	end

	def get_value(property)
		ValueQuery.new.belongs_to_data(self).belongs_to_property(property).find_one
	end

	def has_data?(data)
		DataQuery.new.with_key(self.key).with_data(data.key).set_return('COUNT(r)').get > 0
	end

	def set_value(property, value_content)
		value = get_value property
		if value
			value.content = value_content
			value.save
		else
			value = Value.create value_content
			property.relate_to value, 'HasValue'
			self.relate_to value, 'HasValue'
		end
	end

end