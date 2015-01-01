class Main::Commands::BuildFromTemplate < Main::Commands::BaseCommand
	def run(template)
		@template_path = "#{Neo.app_dir}/modules/main/templates/#{template}"
		unless File.directory? @template_path
			Neo::Exceptions::SystemEror.raise 'Template directory can\'t be found'
		end

		require 'yaml'
		build_models
	end

	def build_models
		model_dir = "#{@template_path}/models"
		model_names = sub_directory_names_of model_dir
		model_names.each do |model_name|
			model = YamlModel.new model_name, model_dir
		end
	end

	def sub_directory_names_of(path)
		Dir["#{path}/*"].lazy.select{
			|p| File.directory? p }.map{|p| File.basename p
		}.to_a
	end

	class YamlModel
		Model = Main::Models::Model

		def initialize(name, dir)
			@dir = dir
			@name = name
			@path = "#{dir}/#{name}"
			generate_db_model
			insert_data
		end

		def extract_schema
			@schema = YAML.load_file("#{@path}/schema.yml").symbolize_keys
		end

		def extract_data
			@data = YAML.load_file("#{@path}/data.yml").symbolize_keys
		end

		def generate_db_model
			extract_schema
			@model = Model.get_by_name @name
			fields = @schema[:fields] || {}
			fields.each do |name, props|
				@model.add_property name, props
			end
		end

		def insert_data
			extract_data
			properties = @model.get_properties.reduce({}) {|memo, property|
				memo[property.name.to_sym] = property
				memo
			}
			@data[@name.to_sym].each do |key, values|
				value_hash = values.reduce({}) { |memo, (property, value_content)|
					property = properties[property]
					memo[property] = value_content
					memo
				}
				@model.create_data value_hash,key
			end
		end
	end
end