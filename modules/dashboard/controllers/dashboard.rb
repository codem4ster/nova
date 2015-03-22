class Dashboard::Controllers::Dashboard < Main::Controllers::Main
	Member = Auth::Models::Member
	Role = Auth::Models::Role

	def index_action
    if Member.logged_in and Member.logged_in.has_role? 'Admin'
      resp = {}
      resp[:title]  = "#{@main_title} - Admin Sayfası"
      render resp
    else
      redirect_to path(:login)
    end
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

	def test_action
		role = Role.new
		role.name = 'Member'
		role.save

		render title: 'OSman'
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