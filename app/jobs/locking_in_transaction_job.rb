class LockingInTransactionJob < ApplicationJob
  queue_as :default

  def perform(update_comment)
    user_comments = User
      .joins(:comments)
      .select('users.*, comments.comment')
      .order(:id)
      .limit(20)

    user_comment = user_comments.sample

    table_lock_log = TableLockLog.create!(
      params: { 
        user_comment: user_comment,
        sleep_seconds: sleep_seconds
      },
      status: :before_locking
    )

    table_lock_log.status = :locking
    table_lock_log.save!

    ActiveRecord::Base.transaction do
      user_comment.comment = update_comment
      # ここでテーブルロックが発生
      # 悲観的ロックを実施
      user_comment.lock!

      sleep sleep_seconds
      user_comment.save!
    end

    table_lock_log.status = :un_locking
    table_lock_log.save!
  end

  def sleep_seconds
    100
  end
end

