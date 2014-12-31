class Main::Models::Model < Neo::Database::Model
	ModelQuery = Main::Models::ModelQuery
	PropertyQuery = Main::Models::PropertyQuery

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
		unless property
			property = Property.create_with_name property_name, options
			self.relate_to property, 'HasProperty'
		end
		property
	end

	def remove_property(property_name)
		PropertyQuery.new.with_name(property_name).with_model(self.name).delete 'r'
	end

	def get_properties

	end

	def set_properties(properties)
		properties.each { |property| add_property property[:name], property[:options] }
	end

	def add_data(data)

	end

	def remove_data(data)

	end

	def get_datas

	end

	def set_datas(datas)

	end

end