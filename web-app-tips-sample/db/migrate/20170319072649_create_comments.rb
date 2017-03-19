class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.integer :user_id, null: false
      t.text :comment, null: false
      t.timestamps
    end
  end
end
