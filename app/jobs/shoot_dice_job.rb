# サイコロ(DiceLog)の悲観ロックを行うクラス
class ShootDiceJob < ApplicationJob
  queue_as :default

  def perform(dice_log)
    dice_lock_log =
      DiceLockLog.create!(dice_log: dice_log, status: :locked)

    ActiveRecord::Base.transaction do
      # 悲観ロック発生
      dice_log.lock!
      dice_log.roll = rand(1..6)
      dice_log.updated_at = Time.now
      sleep 600
      dice_log.save!
    end

    dice_lock_log.unlocked!
    dice_lock_log.save!
  end
end
