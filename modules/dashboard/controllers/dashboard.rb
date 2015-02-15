class Dashboard::Controllers::Dashboard < Main::Controllers::Main
	Member = Auth::Models::Member

	def index_action
		resp = {}
		resp[:title]  = "#{@main_title} - Admin Sayfası"
		render resp
	end

	def login_action
		if Member.logged_in
			redirect path(:home)
		else
			resp = {}
			resp[:title]  = "#{@main_title} - Giriş Yap"

			form = Auth::Forms::Login.new
			if form.posted? and form.valid? and form.authenticate
				redirect path(:home)
			else
				resp[:form] = form
				render resp
			end
		end
	end
end