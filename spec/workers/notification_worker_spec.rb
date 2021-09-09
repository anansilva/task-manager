require 'rails_helper'
require 'sidekiq/testing'

describe NotificationWorker do
  it 'queues a notification job' do
    described_class.perform_async

    expect(described_class.jobs.size).to eq(1)
  end

  it 'creates a notification' do
    Sidekiq::Testing.inline! do
      described_class
        .perform_async('test@test.com', 'testing notifications', 10.seconds.ago)

      expect(Notification.count).to eq(1)
    end
  end
end
