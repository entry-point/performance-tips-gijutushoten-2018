# サイコロのロック状態を保存する
class DiceLockLog < ApplicationRecord
  enum status: %i[locked unlocked]
  belongs_to :dice_log
end
