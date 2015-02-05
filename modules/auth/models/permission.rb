class Auth::Models::Permission < Neo::Database::Model
  PermissionQuery = Auth::Models::PermissionQuery
  UserQuery = Auth::Models::UserQuery
  RoleQuery = Auth::Models::RoleQuery

  attr_accessor :name

  def initialize
    @labels = 'Permission'
  end


  def get_all_user
    UserQuery.new.user_of_permission(self).find
  end

  def get_all_role
    RoleQuery.new.role_of_permission(self).find
  end
end
