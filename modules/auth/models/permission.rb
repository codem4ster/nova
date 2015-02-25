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

  def get_user(user_ip)
    UserQuery.new.user_of_permission(self).by_ip(user_ip).find_one
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

  def get_role(role_name)
    RoleQuery.new.role_of_permission(self).by_name(role_name).find_one
  end

  def add_role(role_name)
    role = get_role role_name
    unless role
      role = RoleQuery.new.by_name(role_name).find_one
      if role
        self.relate_to role, 'HasRole'
      else
        Neo::Exceptions::DatabaseError.new("role cannot found with name: #{role_name}").raise
      end
    end
    role
  end

  def remove_role(role_name)
    role = get_role role_name
    self.unrelate_to(role, 'HasRole') if role
  end
end
