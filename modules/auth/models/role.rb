class Auth::Models::Role < Neo::Database::Model
  RoleQuery = Auth::Models::RoleQuery
  PrivilageQuery = Auth::Models::PrivilageQuery
  UserQuery = Auth::Models::UserQuery

  attr_accessor :name

  def initialize
    @labels = 'Role'
  end


  def get_all_privilage
    PrivilageQuery.new.privilage_of_role(self).find
  end

  def get_all_parent
    RoleQuery.new.parent_of_role(self).find
  end

  def get_all_user
    UserQuery.new.user_of_role(self).find
  end
end
