class Auth::Models::Privilage < Neo::Database::Model
  PrivilageQuery = Auth::Models::PrivilageQuery
  UserQuery = Auth::Models::UserQuery
  RoleQuery = Auth::Models::RoleQuery

  attr_accessor :name

  def initialize
    @labels = 'Privilage'
  end


  def get_all_user
    UserQuery.new.user_of_privilage(self).find
  end

  def get_all_role
    RoleQuery.new.role_of_privilage(self).find
  end
end
