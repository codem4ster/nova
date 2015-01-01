class Main::Models::Value < Neo::Database::Model
	ValueQuery = Main::Models::ValueQuery

	attr_accessor :content

	def initialize
		@labels = 'Value'
	end

	def self.create(content)
		value = Value.new
		value.content = content
		value.save
		value
	end

end