class Auth::Models::User < Neo::Database::Model
  UserQuery = Auth::Models::UserQuery
  PermissionQuery = Auth::Models::PermissionQuery
  RoleQuery = Auth::Models::RoleQuery

  attr_accessor :ip, :last_action

  def initialize
    @labels = 'User'
  end

  def get_all_permission
    PermissionQuery.new.permission_of_user(self).find
  end

  def get_role
    RoleQuery.new.role_of_user(self).find_one
  end

  def has_role?(expected_role)
    role = get_role
    role && role.name==expected_role
  end
end
