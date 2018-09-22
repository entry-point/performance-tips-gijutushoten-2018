class CreateDiceLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :dice_logs do |t|
      t.integer :roll

      t.timestamps
    end
  end
end
