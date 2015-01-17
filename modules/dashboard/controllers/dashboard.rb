module Dashboard
	module Controllers
		class Dashboard < Main::Controllers::Main
			def index_action
				resp = {}
				resp[:title]  = "#{@main_title} - Admin Sayfası"
				render resp
			end
		end
	end
end