class Auth::Models::UserQuery < Neo::Database::Model

  def by_ip(ip)
    self.add_where([%w[ip = {ip}]]).add_parameters ip: ip
  end

  def by_last_action(last_action)
    self.add_where([%w[last_action = {last_action}]])
	    .add_parameters last_action: last_action
  end

  def user_of_privilage(privilage)
    self.add_match('privilage','Privilage',{id: privilage.id}, '-[r:HasUser]->n')
  end
end
