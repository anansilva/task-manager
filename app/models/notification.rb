class Notification < ApplicationRecord
  def unread?
    status == 0
  end

  def read?
    status == 1
  end
end
