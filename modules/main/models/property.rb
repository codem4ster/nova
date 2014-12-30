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

end