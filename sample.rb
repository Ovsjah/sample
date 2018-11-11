Table Users {
  Id,
  Name
}

Table Roles {
  Id,
  Role,
  User_id
}

Table Permissions {
  Id,
  Permission,
  User_id,
  Role_id
}

module Permissions
  def grand(user, permissions, role_id = nil)
    if (user = user.is_a?(User) ? user : User.find_by(name: user))
      permissions.each { |permission| create_permission(user, permission, role_id) }
    end
  end
  
  def grand_via_roles(name, roles, permissions)
    if (user = User.find_by(name: name))
      roles.each do |role|
        role = register_role(user, role)
        grand(user, permissions, role.id)
      end
    end
  end
 
  def register_role(user, role_name)
    return unless user
    user.roles.create(role: role_name, user_id: user.id)
  end
  
  def create_permission(user, permission, role_id)
    return unless user
    user.permissions.create(permission: permission, user_id: user.id, role_id: role_id)
  end  
  
  def has_permision?(name, permission)
    !!User.find_by(name: name)&.permissions&.find_by(permission: permission)
  end
end
