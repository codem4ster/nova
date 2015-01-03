class Main::Components::TemplateBuilder::DataBuilder
	PropertyQuery = Main::Models::PropertyQuery
	Model = Main::Models::Model

	def initialize(yaml_data)
		@data = self.normalize(yaml_data)
	end

	def normalize(yaml_data)
		yaml_data.reduce([]) do |memo, (model, datas)|
			datas.each do |key, values|
				memo << {model: model, key: key, inserted: false, values: values}
			end
			memo
		end
	end

	def find_type_of(model, key)
		PropertyQuery.new.with_name(key).with_model(model).set_return('n.type').get
	end

	def raise_type_mismatch(type, value)
		Neo::Exceptions::SystemError.new(
			"Type Mismatch: #{type} ; #{value}"
		).raise
	end

	def find_in_data(model, key)
		@data.find do |data|
			data[:model] == model.to_sym && data[:key] == key.to_sym
		end
	end

	def get_dependencies(data)
		data[:values].reduce([]) { |memo, (key,value)|
			if value.kind_of? String and value.start_with? '@'
				type = find_type_of(data[:model], key)
				raise_type_mismatch(type, value) unless type.start_with? '@'
				type = type[1..-1].downcase
				value = value[1..-1].downcase
				data[:values][key] = "@#{type}|#{value}"
				memo << find_in_data(type, value)
			elsif value.kind_of? Array
				type = find_type_of(data[:model], key)
				raise_type_mismatch(type, value) unless type.start_with? '@@'
				type = type[2..-1].downcase
				value.each do |value_key|
					value_key = value_key[1..-1].downcase
					memo << find_in_data(type, value_key)
				end
				data[:values][key] << type
			end
			memo
		}
	end

	def insert_values(data)
		model = Model.get_by_name data[:model]
		properties = model.get_properties.reduce({}) {|memo, property|
			memo[property.name.to_sym] = property
			memo
		}
		value_hash = data[:values].reduce({}) { |memo, (key,value)|
			property = properties[key]
			memo[property] = value
			memo
		}
		model.create_data value_hash,data[:key]
	end

	def insert(data)
		unless data[:inserted]
			get_dependencies(data).each {|dependent_data| insert dependent_data }
			insert_values(data)
			data[:inserted] = true
		end
	end

	def build
		@data.each do |data|
			insert data
		end
	end
end