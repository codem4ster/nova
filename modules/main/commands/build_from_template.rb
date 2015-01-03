class Main::Commands::BuildFromTemplate < Main::Commands::BaseCommand
	TemplateBuilder = Main::Components::TemplateBuilder

	def run(template)
		TemplateBuilder.new(template).build
	end
end