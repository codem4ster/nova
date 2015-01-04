class Main::Components::TemplateBuilder
	Transaction = Neo::Database::Transaction

	def initialize(template_name)
		@template_path = "#{Neo.app_dir}/modules/main/templates/#{template_name}"
		unless File.directory? @template_path
			Neo::Exceptions::SystemEror.raise 'Template directory can\'t be found'
		end
	end

	def build
		require 'yaml'
		Transaction.create do
			build_models
		end
	end

	def build_models
		model_dir = "#{@template_path}/models"
		model_names = sub_directory_names_of model_dir
		datas = {}
		model_names.each do |model_name|
			model = YamlModel.new model_name, model_dir
			model.generate_db_model
			datas.deep_merge! model.extract_data
		end
		DataBuilder.new(datas).build
	end

	def sub_directory_names_of(path)
		Dir["#{path}/*"].lazy.select{
			|p| File.directory? p }.map{|p| File.basename p
		}.to_a
	end
end