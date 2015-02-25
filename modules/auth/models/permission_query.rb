class Auth::Models::PermissionQuery < Neo::Database::ModelQuery

  def by_name(name)
    self.add_where([%w[name = {name}]]).add_parameters name: name
  end

  def permission_of_role(role)
    self.add_match('role','Role',{id: role.id}, '-[r:HasPermission]->n')
  end

  def permission_of_user(user)
    self.add_match('user','User',{id: user.id}, '-[r:HasPermission]->n')
  end
end
