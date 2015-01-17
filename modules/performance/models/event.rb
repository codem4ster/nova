class Performance::Models::Event < Neo::Database::Model
	attr_accessor :name, :date

	def initialize
		@labels = 'Event'
	end
end