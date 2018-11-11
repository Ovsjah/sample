Table Users {
  Id,
  Name,
  Permission,
  Role
}


module Permissions
  def grand(name, permission)
    user = User.find_by(name: name)
    user.permission = permission
    user.save
  end
  
  def grand_via_role(name, role_name, permission)
    user = User.find_by(name: name)
    role = Role.new(name, permission)
    user.roll = role
    user.permission = role.permission
    user.save
  end
  
  def has_permision?(name, permission)
    User.find_by(name: name).permission == permission   
  end
end
