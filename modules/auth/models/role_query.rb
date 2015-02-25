class Auth::Models::RoleQuery < Neo::Database::ModelQuery

  def by_name(name)
    self.add_where([%w[name = {name}]]).add_parameters name: name
  end

  def role_of_permission(permission)
    self.add_match('permission','Permission',{id: permission.id}, '-[r:HasRole]->n')
  end

  def role_of_user(user)
    self.add_match('user','User',{id: user.id}, '-[r:HasRole]->n')
  end
end
