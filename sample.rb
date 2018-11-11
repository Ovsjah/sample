Table Users {
  Id,
  Name,
  Permissions,
  Rolls
}


module Permissions
  def grand(name, permission)
    user = User.find_by(name: name)
    user.permissions.push(permission)
    user.save
  end
  
  def grand_via_role(name, role_name, permission)
    user = User.find_by(name: name)
    role = Role.new(name, permission)
    user.rolls.push(role)
    user.permissions.push(role.permission)
    user.save
  end
  
  def has_permision?(name, permission)
    User.find_by(name: name).permissions.include?(permission)
  end
end
