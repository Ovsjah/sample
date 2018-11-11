Table Users {
  Id,
  Name
}

Table Rolls {
  Id,
  Roll,
  User_id,
  Permission_id
}

Table Permissions {
  Id,
  Permission,
  User_id,
  Roll_id
}

module Permissions
  def grand(name, permission)
    User.find_by(name: name)&.permissions&.create(permission: permission, user_id: user.id)
  end
  
  def grand_via_role(name, role_name, permission)
    new_permission = grand(name, permission)
    User.find_by(name: name)&.rolls&.create(role: role_name, user_id: user.id, permission_id: new_permission.id)
  end
  
  def has_permision?(name, permission)
    !!User.find_by(name: name)&.permissions&.find_by(permission: permission)
  end
end
