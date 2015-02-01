class Auth::Models::PrivilageQuery < Neo::Database::Model

  def by_name(name)
    self.add_where([%w[name = {name}]]).add_parameters name: name
  end

  def privilage_of_user(user)
    self.add_match('user','User',{id: user.id}, '-[r:HasPrivilage]->n')
  end
end
