class CreateDiceLockLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :dice_lock_logs do |t|
      t.integer :dice_log_id
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
