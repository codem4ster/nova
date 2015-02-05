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

  def get_all_parent
    RoleQuery.new.parent_of_role(self).find
  end

  def get_all_user
    UserQuery.new.user_of_role(self).find
  end
end
