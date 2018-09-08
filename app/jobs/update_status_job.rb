class UpdateStatusJob < ApplicationJob
  queue_as :async_sample

  def perform(*args)
    sleep 15
    update_status = UpdateStatus.new(['ok', 'ng', 'waiting'].sample)
    update_status.execute
  end
end
