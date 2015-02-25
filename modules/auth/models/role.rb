class Auth::Models::Role < Neo::Database::Model
  RoleQuery = Auth::Models::RoleQuery
  PermissionQuery = Auth::Models::PermissionQuery
  UserQuery = Auth::Models::UserQuery

  attr_accessor :name

  def initialize
    @labels = 'Role'
  end

	def self.create_with_name(name)
		role = self.new
		role.name = name
		role.save
		role
	end

  def self.create_unique(name)
	  role = RoleQuery.new.by_name(name).find_one
	  role or create_with_name(name)
  end

  def get_all_permission
	  PermissionQuery.new.permission_of_role(self).find
  end

  def get_all_user
	  UserQuery.new.user_of_role(self).find
  end

  def get_permission(permission_name)
	  PermissionQuery.new.permission_of_role(self).by_name(permission_name).find_one
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

  def get_user(user_ip)
	  UserQuery.new.user_of_role(self).by_ip(user_ip).find_one
  end

  def add_user(user_ip)
	  user = get_user user_ip
	  unless user
		  user = UserQuery.new.by_ip(user_ip).find_one
		  if user
			  self.relate_to user, 'HasUser'
		  else
			  Neo::Exceptions::DatabaseError.new("user cannot found with ip: #{user_ip}").raise
		  end
	  end
	  user
  end

  def remove_user(user_ip)
	  user = get_user user_ip
	  self.unrelate_to(user, 'HasUser') if user
  end
end
