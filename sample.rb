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
  def grand(user, permissions, roll_id = nil)
    user = user.is_a?(User) ? user : User.find_by(name: user)
    permissions.each { |permission| create_permission(user, permission, roll_id) }
  end
  
  def grand_via_role(name, role_name, permissions)
    user = User.find_by(name: name)
    roll = user.rolls.create(role: role_name, user_id: user.id) if user
    grand(user, permissions, roll.id) if roll
  end
  
  def create_permission(user, permission, roll_id)
    return unless user
    user.permissions.create(permission: permission, user_id: user.id, roll_id: roll_id)
  end  
  
  def has_permision?(name, permission)
    !!User.find_by(name: name)&.permissions&.find_by(permission: permission)
  end
end
