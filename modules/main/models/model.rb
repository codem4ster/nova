class Main::Models::Model < Neo::Database::Model
	ModelQuery = Main::Models::ModelQuery
	PropertyQuery = Main::Models::PropertyQuery
	DataQuery = Main::Models::DataQuery
	Data = Main::Models::Data

	attr_accessor :name

	def initialize
		@labels = 'Model'
	end

	def self.get_by_name(name)
		model = ModelQuery.new.with_name(name).find_one
		unless model
			model = Model.new
			model.name = name
			model.save
		end
		model
	end

	def get_property(property_name)
		PropertyQuery.new.with_name(property_name).with_model(self.name).find_one
	end

	def add_property(property_name, options)
		property = get_property(property_name)
		if property
			property.update options
		else
			property = Property.create_with_name property_name, options
			self.relate_to property, 'HasProperty'
		end
		property
	end

	def remove_property(property_name)
		PropertyQuery.new.with_name(property_name).with_model(self.name).delete 'r'
	end

	def get_properties
		PropertyQuery.new.with_model(self.name).find
	end

	def set_properties(properties)
		properties.each { |property| add_property property[:name], property[:options] }
	end

	def create_data(values, key=nil)
		relate = false
		if key
			data = DataQuery.new.with_key(key).find_one
			unless data
				data = Data.new
				data.key = key
				data.save
				relate = true
			end
		else
			data = Data.new
			data.save
			relate = true
		end
		values.each do |property, value|
			if value.kind_of? String and value.start_with? '@'
				value = value[1..-1]
				model, rel_key = value.split('|')
				relation_data = DataQuery.new.with_model(model).with_key(rel_key).find_one
				property.relate_to relation_data, 'HasData' unless property.has_data? relation_data
				data.relate_to relation_data, 'HasData' unless data.has_data? relation_data
			elsif value.kind_of? Array
				model = value.pop
				value.each do |v|
					rel_key = v[1..-1]
					relation_data = DataQuery.new.with_model(model).with_key(rel_key).find_one
					property.relate_to relation_data, 'HasData' unless property.has_data? relation_data
					data.relate_to relation_data, 'HasData' unless data.has_data? relation_data
				end
			else
				data.set_value property, value
			end
		end
		self.relate_to data, 'HasData' if relate
	end

	def remove_data(data)

	end

	def update_data(data, values)

	end

	def get_datas

	end

end