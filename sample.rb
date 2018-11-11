Table Users {
  Id,
  Name,
  Permission,
  Role
}


module Permissions
  def get_user(name)
    Users.all.detect { |user| user.name == name }
  end

  def grand(name, permission)
    user = get_user(name)
    user.permission = permission
    user.save
  end
  
  def grand_via_role(name, role_name, permission)
    user = get_user(name)
    role = Role.new(name, permission)
    user.roll = role
    user.permission = role.permission
    user.save
  end
  
  def has_permision?(name, permission)
    get_user(name).permission == permission   
  end
end
