class User < ApplicationRecord
  has_secure_password

  def manager?
    role == 0
  end

  def technician?
    role == 1
  end
end
