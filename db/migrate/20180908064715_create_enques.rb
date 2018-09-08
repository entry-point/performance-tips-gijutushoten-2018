class CreateEnques < ActiveRecord::Migration[5.2]
  def change
    create_table :enques do |t|
      t.integer :elapsed_time
      t.string :status

      t.timestamps
    end
  end
end
