class CreateTableLockLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :table_lock_logs do |t|
      t.json :params
      t.string :status

      t.timestamps
    end
  end
end
