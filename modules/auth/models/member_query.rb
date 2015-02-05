class Auth::Models::MemberQuery < Auth::Models::UserQuery

	def by_username_or_email(username, email)
		by_username username, 'OR';	by_email email
	end

  def by_username(username, operator='AND')
    self.add_where([%w[username = {username}]], operator).add_parameters username: username
  end

  def by_email(email)
    self.add_where([%w[email = {email}]]).add_parameters email: email
  end

  def by_password(password)
    self.add_where([%w[password = {password}]]).add_parameters password: password
  end

  def by_salt(salt)
    self.add_where([%w[salt = {salt}]]).add_parameters salt: salt
  end

  def by_active(active)
    self.add_where([%w[active = {active}]]).add_parameters active: active
  end

  def by_activation_code(activation_code)
    self.add_where([%w[activation_code = {activation_code}]])
	    .add_parameters activation_code: activation_code
  end

  def by_pass_requested_at(pass_requested_at)
    self.add_where([%w[pass_requested_at = {pass_requested_at}]])
	    .add_parameters pass_requested_at: pass_requested_at
  end

  def by_pass_request_code(pass_request_code)
    self.add_where([%w[pass_request_code = {pass_request_code}]])
	    .add_parameters pass_request_code: pass_request_code
  end

  def by_hidden_answer(hidden_answer)
    self.add_where([%w[hidden_answer = {hidden_answer}]])
	    .add_parameters hidden_answer: hidden_answer
  end

  def by_last_login(last_login)
    self.add_where([%w[last_login = {last_login}]]).add_parameters last_login: last_login
  end

  def by_signed_at(signed_at)
    self.add_where([%w[signed_at = {signed_at}]]).add_parameters signed_at: signed_at
  end
end
