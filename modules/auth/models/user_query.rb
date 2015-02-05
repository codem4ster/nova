class Auth::Models::UserQuery < Neo::Database::ModelQuery

  def by_ip(ip)
    self.add_where([%w[ip = {ip}]]).add_parameters ip: ip
  end

  def by_last_action(last_action)
    self.add_where([%w[last_action = {last_action}]]).add_parameters last_action: last_action
  end

  def user_of_permission(permission)
    self.add_match('permission','Permission',{id: permission.id}, '-[r:HasUser]->n')
  end
end
