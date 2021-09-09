class User < ApplicationRecord
  has_secure_password

  has_many :tasks

  def manager?
    role == 0
  end

  def technician?
    role == 1
  end

  def serialize_role
    if role == 0
      'Manager'
    else
      'Technician'
    end
  end
end
