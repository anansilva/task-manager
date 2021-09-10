class NotificationWorker
  include Sidekiq::Worker

  def perform(technician_email, task_name, performed_at)
    Notification.create!(
      message: notification_message(technician_email, task_name, performed_at),
      status: 1
    )
  end

  private

  def notification_message(technician_email, task_name, performed_at)
    """
      The technician #{technician_email} performed the task '#{task_name}'
      on #{performed_at}.
    """
  end
end
