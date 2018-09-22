module Api
  # サイコロの目を更新
  # テーブルの行ロック(悲観ロック)のためのサンプル
  class ShootDiceController < ApplicationController
    def show
      render json: { dice_log: dice_log }
    end

    def create
      # 行単位の悲観ロックを
      # 非同期Jobで実行する
      ShootDiceJob.perform_later(dice_log)

      render json: { status: 'ok', dice_log: dice_log.reload }
    end

    private

    def dice_log
      @dice_log ||= DiceLog.order(id: :desc).first
    end
  end
end
