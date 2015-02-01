class Dashboard::Controllers::Dashboard < Main::Controllers::Main
	def index_action
		resp = {}
		resp[:title]  = "#{@main_title} - Admin Sayfası"
		render resp
	end

	def login_action
		resp = {}
		resp[:title]  = "#{@main_title} - Giriş Yap"

		form = Auth::Forms::Login.new
		if form.posted? and form.valid?
			'do smt'
		end

		resp[:form] = form
		render resp
	end
end