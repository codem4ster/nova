class Auth::Models::RoleQuery < Neo::Database::Model

  def by_name(name)
    self.add_where([%w[name = {name}]]).add_parameters name: name
  end

  def parent_of_role(role)
    self.add_match('role','Role',{id: role.id}, '-[r:HasParent]->n')
  end

  def role_of_user(user)
    self.add_match('user','User',{id: user.id}, '-[r:HasRole]->n')
  end
end
