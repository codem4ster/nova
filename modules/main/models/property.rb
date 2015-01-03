class Main::Models::Property < Neo::Database::Model
	PropertyQuery = Main::Models::PropertyQuery

	attr_accessor :name, :label, :type, :validations

	def initialize
		@labels = 'Property'
	end

	def self.get_by_name(name)
		ModelQuery.new.with_name(name).find_one
	end

	def self.create_with_name(name, options)
		property = Property.new
		property.name = name
		property.label = options[:label]
		property.type = options[:type]
		property.validations = options[:validations].to_json
		property.save
		property
	end

	def has_data?(data)
		PropertyQuery.new.with_name(self.name).with_data(data.key).set_return('COUNT(r)').get > 0
	end

	def update(options)
		is_different = [:label, :type, :validations].any? {|key|
			val = (key == :validations) ? options[key].to_json : options[key]
			self.send(key) != val
		}
		if is_different
			self.label = options[:label]
			self.type = options[:type]
			self.validations = options[:validations].to_json
			self.save
		end
		self
	end

end