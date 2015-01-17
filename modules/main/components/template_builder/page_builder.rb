# Write page data to neo4j under given pages_directory
class Main::Components::TemplateBuilder::PageBuilder

	# initialize variables
	# @param pages_directory [String]
	#   directory which includes pages under templates folder
	def initialize(pages_directory)
		Dir["#{pages_directory}/*"].reduce {} do |path|
			if File.directory? path
				File.basename
			end
		end
		tree = page_groups.reduce {} do |page_group|
			Dir["#{page_dir}/#{page_group}/*.haml"]
		end
	end

	def build

	end
end