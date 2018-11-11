Table Users {
  Id,
  Name
}

Table Rolls {
  Id,
  Roll,
  User_id
}

Table Permissions {
  Id,
  Permission,
  User_id,
  Roll_id
}

module Permissions
  def grand(name, permission, roll_id = nil)
    user = User.find_by(name: name)
    user.permissions.create(permission: permission, user_id: user.id, roll_id: roll_id) if user
  end
  
  def grand_via_role(name, role_name, permission)
    user = User.find_by(name: name)
    roll = user.rolls.create(role: role_name, user_id: user.id) if user
    grand(name, permission, roll.id ) if roll
  end
  
  def has_permision?(name, permission)
    !!User.find_by(name: name)&.permissions&.find_by(permission: permission)
  end
end
