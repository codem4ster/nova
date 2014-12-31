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
			extract_schema
			generate_db_model
		end

		def extract_schema
			@schema = YAML.load_file("#{@path}/schema.yml").symbolize_keys
		end

		def generate_db_model
			model = Model.get_by_name @name
			fields = @schema[:fields] || {}
			fields.each do |name, props|
				#model.add_property name, props
				model.remove_property name
			end
		end
	end
end