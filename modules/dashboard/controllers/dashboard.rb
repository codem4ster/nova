class Dashboard::Controllers::Dashboard < Main::Controllers::Main
	Member = Auth::Models::Member

	def index_action
		resp = {}
		resp[:title]  = "#{@main_title} - Admin Sayfası"
		render resp
	end

	def login_action
		if Member.logged_in
      redirect_logged_in_member
		else
			resp = {}
			resp[:title]  = "#{@main_title} - Giriş Yap"

			form = Auth::Forms::Login.new
			if form.posted? and form.valid? and form.authenticate
        redirect_logged_in_member
			else
				resp[:form] = form
				render resp
			end
		end
  end

  def logout_action
    Member.logout
    redirect_to path(:home)
  end

  private
    def redirect_logged_in_member
      if Member.logged_in.has_role? 'Admin'
        redirect_to path(:dashboard)
      else
        redirect_to path(:home)
      end
    end
end