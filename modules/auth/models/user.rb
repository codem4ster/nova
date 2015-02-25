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

  def has_role?(expected_roles)
    @role ||= get_role
    expected_roles = [expected_roles] unless expected_roles.kind_of? Array
    @role and expected_roles.any?{|role_name| @role.name==role_name}
  end

  def has_permission?(permission)
	  @role ||= get_role
	  get_permission permission or @role.get_permission permission
  end

  def set_role(role)
	  prev = get_role
	  if prev and prev != role
		  self.unrelate_to role, 'HasRole'
	  end
	  if not prev or prev != role
		  self.relate_to role, 'HasRole'
	  end
  end

  def get_permission(permission_name)
	  PermissionQuery.new.permission_of_user(self).by_name(permission_name).find_one
  end

  def add_permission(permission_name)
	  permission = get_permission permission_name
	  unless permission
		  permission = PermissionQuery.new.by_name(permission_name).find_one
		  if permission
			  self.relate_to permission, 'HasPermission'
		  else
			  Neo::Exceptions::DatabaseError.new("permission cannot found with name: #{permission_name}").raise
		  end
	  end
	  permission
  end

  def remove_permission(permission_name)
	  permission = get_permission permission_name
	  self.unrelate_to(permission, 'HasPermission') if permission
  end
end
