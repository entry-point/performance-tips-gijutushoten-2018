class CreateEnqueJob < ApplicationJob
  queue_as :default

  def perform(*args)
    sleep_time = rand(5..30)
    sleep sleep_time

    enque = Enque.find(args.first)
    enque.elapsed_time = sleep_time
    enque.status = '完了'
    enque.save!
  end
end
